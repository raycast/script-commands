#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Shuffle Toggle
# @raycast.mode silent

# Optional parameters:
# @raycast.author Caleb Stauffer
# @raycast.authorURL https://github.com/crstauf
# @raycast.description Shuffle Music
# @raycast.packageName Music
# @raycast.icon images/music-logo.png

tell application "Music"

	if shuffle enabled = false then
		
		set shuffle enabled to true
		do shell script "echo Shuffle on"
	
	else if shuffle enabled = true then
	
		set shuffle enabled to false
		do shell script "echo Shuffle off"
	
	end if
	
end tell