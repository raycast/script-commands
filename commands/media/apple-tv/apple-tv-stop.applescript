#!/usr/bin/osascript

# @raycast.schemaVersion 1
# @raycast.title Stop
# @raycast.mode silent
# @raycast.author Caleb Stauffer
# @raycast.authorURL https://github.com/crstauf
# @raycast.description Stop TV
# @raycast.packageName TV
# @raycast.icon images/apple-tv-logo.png

tell application "TV"
	stop
end tell

do shell script "echo Stopped TV"