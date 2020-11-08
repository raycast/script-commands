#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Previous
# @raycast.mode silent

# Optional parameters:
# @raycast.author Caleb Stauffer
# @raycast.authorURL https://github.com/crstauf
# @raycast.description Previous track in Music
# @raycast.packageName Music
# @raycast.icon images/music-logo.png

tell application "Music"
	previous track
end tell

do shell script "echo Previous track"