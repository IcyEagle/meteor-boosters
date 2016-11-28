fs = require "fs"
{output, checkFile} = require "../helpers"

module.exports = (settings) ->
	file = ".gitignore"

	content = if checkFile file then fs.readFileSync file, "utf-8" else ""

	line = "#{settings["settingsDirectory"]}/#{settings["environmentFiles"]["local"]}".replace "%ENV%", "*"
	has = content.indexOf(line) isnt -1
	if has
		output "#{file} is already configured".yellow
	else
		content += line + "\n"
		fs.writeFileSync file, content
		output "Modify #{file}".green
