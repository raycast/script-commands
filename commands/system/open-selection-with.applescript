#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Open Selection With
# @raycast.mode silent
# @raycast.packageName System
# @raycast.argument1 { "type": "text", "placeholder": "Application", "optional": false }
#
# Optional parameters:
# @raycast.icon 🗃
#
# Documentation:
# @raycast.description Open selected items in Finder with the given application.
# @raycast.author Felipe Turcheti
# @raycast.authorURL https://felipeturcheti.com

on run {appName}
	log "Opening selection with \"" & appName & "\"…"

	-- get the bundle id for the application name received as a parameter
	set bundleId to id of application appName

	tell application "Finder"
		-- get Finder selected items
		set theItems to selection
		-- get the path for the application with the bundle id defined above
		set appPath to (POSIX path of (application file id bundleId as alias))
	end tell

	-- for each item in the Finder selection
	repeat with itemRef in theItems
		-- get the item path
		set theItem to POSIX path of (itemRef as string)
		-- set a shell command to open the item with the desired application
		-- note:
			-- opening the file with applescript often results in permission errors
			-- but opening it with a shell script seems to bypass this issue
		set command to "open -a " & quoted form of appPath & " " & quoted form of theItem
		do shell script command
	end repeat
end run
