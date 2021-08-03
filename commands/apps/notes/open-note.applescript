#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Open Note
# @raycast.mode compact

# Optional parameters:
# @raycast.icon ./images/notes.png
# @raycast.argument1 { "type": "text", "placeholder": "Note Title" }
# @raycast.packageName Notes

# Documentation:
# @raycast.description Open Note via its Title
# @raycast.author Vardan Sawhney
# @raycast.authorURL https://github.com/commai

on run argv
	tell application "Notes"
		if exists note (item 1 of argv)
			show note (item 1 of argv)
		else 
			log "Sorry, the note \"" & (item 1 of argv) & "\" was not found" 
		end if
	end tell
end run
