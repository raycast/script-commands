#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Append Content From Clipboard
# @raycast.mode silent

# Optional parameters:
# @raycast.icon ./images/notes.png
# @raycast.argument1 { "type": "text", "placeholder": "Note Name" }
# @raycast.packageName Notes

# Documentation:
# @raycast.description Script to append to an existing note content from clipboard.
# @raycast.author Ayoub Gharbi
# @raycast.authorURL https://github.com/ayoub-g

on run argv 
	tell application "Notes"
		set note_name to (item 1 of argv)
		if exists note note_name then
			
			show note note_name
			set new_content to the clipboard
			set note_content to body of note note_name 
			set body of note note_name to note_content & new_content
		else
			log "Note \"" & note_name & "\" was not found"
		end if
	end tell
end run
