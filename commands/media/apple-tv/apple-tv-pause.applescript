#!/usr/bin/osascript

# @raycast.schemaVersion 1
# @raycast.title Pause
# @raycast.mode silent
# @raycast.author Caleb Stauffer
# @raycast.authorURL https://github.com/crstauf
# @raycast.description Pause TV
# @raycast.packageName TV
# @raycast.icon images/apple-tv-logo.png

tell application "TV"
	if player state is playing then 
		pause
		do shell script "echo Paused TV"
	end if
end tell