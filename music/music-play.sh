#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Play
# @raycast.mode silent

# Optional parameters:
# @raycast.author Caleb Stauffer
# @raycast.authorURL https://github.com/crstauf
# @raycast.description Play Music
# @raycast.packageName Music
# @raycast.icon images/music-logo.png

tell application "Music"
	if player state is paused then 
		play
		do shell script "echo Playing music"
	end if
end tell