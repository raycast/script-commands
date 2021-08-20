#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Create Note
# @raycast.mode silent

# Optional parameters:
# @raycast.icon ./images/notes.png
# @raycast.argument1 { "type": "text", "placeholder": "Note Name" }
# @raycast.argument2 { "type": "text", "placeholder": "Text" }
# @raycast.packageName Notes

# Documentation:
# @raycast.description Create a new Note 
# @raycast.author Vardan Sawhney
# @raycast.authorURL https://github.com/commai


on run argv
	set content to "<body><h1 style=\"color:black;\"> " & (item 1 of argv)  & "</h1> 
	<p style=\"color:black;\" >" & (item 2 of argv) & "</p>
	</body>"
	
	tell application "Notes"
		activate
		make new note at folder "Notes" with properties {name: "", body:content}
	end tell
end run
