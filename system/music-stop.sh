#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Stop
# @raycast.mode silent

# Optional parameters:
# @raycast.author Caleb Stauffer
# @raycast.authorURL https://github.com/crstauf
# @raycast.description Stop Music
# @raycast.packageName Music
# @raycast.icon images/music-logo.png

tell application "Music"
	stop
end tell