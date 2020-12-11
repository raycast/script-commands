#!/usr/bin/osascript

# @raycast.title Pause
# @raycast.author Caleb Stauffer
# @raycast.authorURL https://github.com/crstauf
# @raycast.description Pause TV.

# @raycast.icon images/apple-tv-logo.png
# @raycast.mode silent
# @raycast.packageName TV
# @raycast.schemaVersion 1

tell application "TV"
	if player state is playing then 
		pause
		do shell script "echo Paused TV"
	end if
end tell