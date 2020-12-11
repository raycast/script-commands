#!/usr/bin/osascript

# @raycast.title Play
# @raycast.author Caleb Stauffer
# @raycast.authorURL https://github.com/crstauf
# @raycast.description Play TV.

# @raycast.icon images/apple-tv-logo.png
# @raycast.mode silent
# @raycast.packageName TV
# @raycast.schemaVersion 1

tell application "TV"
	if player state is paused then 
		play
		do shell script "echo Playing TV"
	end if
end tell