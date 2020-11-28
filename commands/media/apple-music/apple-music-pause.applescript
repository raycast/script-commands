#!/usr/bin/osascript

# @raycast.title Pause
# @raycast.author Caleb Stauffer
# @raycast.authorURL https://github.com/crstauf
# @raycast.description Pause Music.

# @raycast.icon images/apple-music-logo.png
# @raycast.mode silent
# @raycast.packageName Music
# @raycast.schemaVersion 1

tell application "Music"
	if player state is playing then 
		pause
		do shell script "echo Paused music"
	end if
end tell