#!/usr/bin/osascript

# @raycast.title Play
# @raycast.author Caleb Stauffer
# @raycast.authorURL https://github.com/crstauf
# @raycast.description Play Music.

# @raycast.icon images/apple-music-logo.png
# @raycast.mode silent
# @raycast.packageName Music
# @raycast.schemaVersion 1

tell application "Music"
	if player state is paused then 
		play
		do shell script "echo Playing music"
	end if
end tell