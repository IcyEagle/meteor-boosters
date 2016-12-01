fs = require "fs"
{output, checkFile, SETTINGS_DIR} = require "../helpers"

file = ".gitignore"

ensureLine = (content, line) ->
	has = content.indexOf(line) isnt -1
	if has
		output "#{file} is already configured".yellow
	else
		content += line + "\n"
		fs.writeFileSync file, content
		output "Modify #{file}".green

module.exports = (settings) ->
	content = if checkFile file then fs.readFileSync file, "utf-8" else ""

	line = "#{settings["settingsDirectory"]}/#{settings["environmentFiles"]["local"]}".replace "%ENV%", "*"
	ensureLine content, line
	ensureLine "/#{SETTINGS_DIR}"
