#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Create Note From Clipboard
# @raycast.mode silent

# Optional parameters:
# @raycast.icon ./images/notes.png
# @raycast.argument1 { "type": "text", "placeholder": "Note Name" }
# @raycast.packageName Notes

# Documentation:
# @raycast.description Create Note From Clipboard
# @raycast.author Ayoub Gharbi
# @raycast.authorURL https://github.com/ayoub-g

on run argv
	set content to "<body><h1 style=\"color:black;\"> " & (item 1 of argv)  & "</h1> 
	<p style=\"color:black;\" >" & (the clipboard as Unicode text) & "</p>
	</body>"
tell application "Notes"
		activate
		make new note at folder "Notes" with properties {name:"", body:content}
	end tell
end run
