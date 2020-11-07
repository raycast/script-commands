#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Play
# @raycast.mode silent

# Optional parameters:
# @raycast.author Caleb Stauffer
# @raycast.authorURL https://github.com/crstauf
# @raycast.description Play TV
# @raycast.packageName TV
# @raycast.icon images/tv-logo.png

tell application "TV"
	if player state is paused then 
		play
		do shell script "echo Playing TV"
	end if
end tell