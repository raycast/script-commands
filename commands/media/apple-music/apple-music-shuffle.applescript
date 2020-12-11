#!/usr/bin/osascript

# @raycast.title Toggle Shuffle
# @raycast.author Caleb Stauffer
# @raycast.authorURL https://github.com/crstauf
# @raycast.description Toggle shuffle setting in Music.

# @raycast.icon images/apple-music-logo.png
# @raycast.mode silent
# @raycast.packageName Music
# @raycast.schemaVersion 1

tell application "Music"

	if shuffle enabled = false then
		
		set shuffle enabled to true
		do shell script "echo Shuffle playlist on"
	
	else if shuffle enabled = true then
	
		set shuffle enabled to false
		do shell script "echo Shuffle playlist off"
	
	end if
	
end tell