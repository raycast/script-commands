#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Quick Terminal
# @raycast.mode compact

# Optional parameters:
# @raycast.icon ./images/Terminal icon.png
# @raycast.argument1 { "type": "text", "placeholder": "Command (opt)", "optional": true }

# Documentation:
# @raycast.description Quickly pass a command to terminal and display the output (or open Terminal if no input is given)
# @raycast.author Rediwed
# @raycast.authorURL github.com/Rediwed

on run argv
	if (item 1 of argv) is "" then
		tell application "Terminal"
			if not running then
				run
				delay 0.25
			end if
			activate
			log "No input detected, activated Terminal"
		end tell
	else
		log (do shell script (item 1 of argv))
	end if
end run