#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Search Notes
# @raycast.mode compact

# Optional parameters:
# @raycast.icon ./images/notes.png
# @raycast.argument1 { "type": "text", "placeholder": "Note Title" }
# @raycast.packageName Notes

# Documentation:
# @raycast.description Search for a Note by Title
# @raycast.author Vardan Sawhney
# @raycast.authorURL https://github.com/commai

on run argv
	tell application "Notes"
		show note (item 1 of argv)
	end tell
end run
