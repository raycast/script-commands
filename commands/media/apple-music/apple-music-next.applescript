#!/usr/bin/osascript

# @raycast.title Next Track
# @raycast.author Caleb Stauffer
# @raycast.authorURL https://github.com/crstauf
# @raycast.description Next track in Music.

# @raycast.icon images/apple-music-logo.png
# @raycast.mode silent
# @raycast.packageName Music
# @raycast.schemaVersion 1

tell application "Music"
	next track
end tell

do shell script "echo Next track"