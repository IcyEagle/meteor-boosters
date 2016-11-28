fs = require "fs"
{output, formatJSON, getProjectSettingsPath} = require "../helpers"

module.exports = (settings, data) ->
	file = getProjectSettingsPath settings
	output "Save project configuration".green
	fs.writeFileSync file, formatJSON data
