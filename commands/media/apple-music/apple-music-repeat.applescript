#!/usr/bin/osascript

# @raycast.title Toggle Repeat
# @raycast.author Caleb Stauffer
# @raycast.authorURL https://github.com/crstauf
# @raycast.description Toggle repeat setting in Music.

# @raycast.icon images/apple-music-logo.png
# @raycast.mode silent
# @raycast.packageName Music
# @raycast.schemaVersion 1

tell application "Music"

	if song repeat = off then

		set song repeat to all
		do shell script "echo Repeating playlist"
	
	else if song repeat = all then
		
		set song repeat to one
		do shell script "echo Repeating track"
		
	else if song repeat = one
		
		set song repeat to off
		do shell script "echo Repeating off"
	
	end if
	
end tell