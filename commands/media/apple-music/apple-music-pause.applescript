#!/usr/bin/osascript

# @raycast.schemaVersion 1
# @raycast.title Pause
# @raycast.mode silent
# @raycast.author Caleb Stauffer
# @raycast.authorURL https://github.com/crstauf
# @raycast.description Pause Music
# @raycast.packageName Music
# @raycast.icon images/apple-music-logo.png

tell application "Music"
	if player state is playing then 
		pause
		do shell script "echo Paused music"
	end if
end tell