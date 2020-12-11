#!/usr/bin/osascript

# @raycast.title Previous Track
# @raycast.author Caleb Stauffer
# @raycast.authorURL https://github.com/crstauf
# @raycast.description Previous track in Music.

# @raycast.icon images/apple-music-logo.png
# @raycast.mode silent
# @raycast.packageName Music
# @raycast.schemaVersion 1

tell application "Music"
	previous track
end tell

do shell script "echo Previous track"