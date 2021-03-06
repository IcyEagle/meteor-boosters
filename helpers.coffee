fs = require "fs"

SETTINGS_DIR = ".boosters"
SETTINGS_FILE = "boosters.json"
MONGO_FILE = "mongo.json"

output = -> console.log.apply null, arguments

checkFile = (file) -> fs.existsSync file

ensureDirectory = (directory) ->
	fs.mkdirSync directory unless checkFile directory

formatJSON = (json) -> JSON.stringify json, null, '\t'

getProjectSettingsPath = (settings) -> "#{process.cwd()}/#{SETTINGS_DIR}/#{settings["projectSettings"]}"

getMongoSettingsPath = -> "#{process.cwd()}/#{SETTINGS_DIR}/#{MONGO_FILE}"

getDefaultSecureDirectoryPath = (settings) -> "#{process.cwd()}/#{settings["secureDirectory"]}"

module.exports =
	output: output
	checkFile: checkFile
	ensureDirectory: ensureDirectory
	formatJSON: formatJSON
	getProjectSettingsPath: getProjectSettingsPath
	getDefaultSecureDirectoryPath: getDefaultSecureDirectoryPath
	getMongoSettingsPath: getMongoSettingsPath
	SETTINGS_FILE: SETTINGS_FILE
	SETTINGS_DIR: SETTINGS_DIR
