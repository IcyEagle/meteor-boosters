fs = require "fs"
{output, checkFile, ensureDirectory, formatJSON} = require "../helpers"
environmentSettings = require "./environmentSettings"

createMainSettingsFile = (directory, environment, settings) -> createSettingFile "main", directory, environment, settings

createLocalSettingsFile = (directory, environment, settings) -> createSettingFile "local", directory, environment, settings

createSettingFile = (file, directory, environment, settings) ->
	filename = settings["environmentFiles"][file].replace "%ENV%", environment
	path = "#{directory}/#{filename}"
	unless checkFile path
		output "Create #{path}".green
		content = environmentSettings[file][environment]()
		fs.writeFileSync path, formatJSON content
	else
		output "#{path} already exists".yellow

createSpecificSettingsFile = (directory, secureDirectory, environment, settings) ->
	file = "specific"
	filename = settings["environmentFiles"][file].replace "%ENV%", environment

	target = "#{secureDirectory}/#{filename}"
	path = "#{directory}/#{filename}"
	unless checkFile target
		content = environmentSettings[file][environment]()
		fs.writeFileSync target, formatJSON content
	unless checkFile path
		fs.symlinkSync target, path

configureEnvironmentSettings = (environment, settings, projectSettings) ->
	directory = settings["settingsDirectory"]
	secureDirectory = "#{projectSettings["secureDirectory"]}/settings"
	ensureDirectory secureDirectory

	createMainSettingsFile directory, environment, settings
	createSpecificSettingsFile directory, secureDirectory, environment, settings
	createLocalSettingsFile directory, environment, settings

module.exports = (settings, projectSettings) ->
	ensureDirectory settings["settingsDirectory"]
	configureEnvironmentSettings environment, settings, projectSettings for environment in settings["environments"]
