#!/usr/bin/osascript

# @raycast.title Set Volume
# @raycast.author Caleb Stauffer
# @raycast.authorURL https://github.com/crstauf
# @raycast.description Set volume in TV.

# @raycast.icon images/apple-tv-logo.png
# @raycast.mode silent
# @raycast.packageName TV
# @raycast.schemaVersion 1

# @raycast.argument1 { "type": "text", "placeholder": "Level" }

on run argv
	tell application "TV"
		set the sound volume to (item 1 of argv)
	end tell
end run
