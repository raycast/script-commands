#!/usr/bin/osascript

# @raycast.schemaVersion 1
# @raycast.title Stop
# @raycast.mode silent
# @raycast.author Caleb Stauffer
# @raycast.authorURL https://github.com/crstauf
# @raycast.description Stop Music
# @raycast.packageName Music
# @raycast.icon images/apple-music-logo.png

tell application "Music"
	stop
end tell

do shell script "echo Stopped music"