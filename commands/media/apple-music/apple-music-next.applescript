#!/usr/bin/osascript

# @raycast.schemaVersion 1
# @raycast.title Next
# @raycast.mode silent
# @raycast.author Caleb Stauffer
# @raycast.authorURL https://github.com/crstauf
# @raycast.description Next track in Music
# @raycast.packageName Music
# @raycast.icon images/apple-music-logo.png

tell application "Music"
	next track
end tell

do shell script "echo Next track"