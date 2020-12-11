#!/usr/bin/osascript

# @raycast.title Set Volume
# @raycast.author Caleb Stauffer
# @raycast.authorURL https://github.com/crstauf
# @raycast.description Set volume in Music.

# @raycast.icon images/apple-music-logo.png
# @raycast.mode silent
# @raycast.packageName Music
# @raycast.schemaVersion 1

# @raycast.argument1 { "type": "text", "placeholder": "Level" }

on run argv
	tell application "Music"
		set the sound volume to (item 1 of argv)
	end tell
end run
