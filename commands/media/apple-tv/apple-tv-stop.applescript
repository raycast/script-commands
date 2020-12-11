#!/usr/bin/osascript

# @raycast.title Stop
# @raycast.author Caleb Stauffer
# @raycast.authorURL https://github.com/crstauf
# @raycast.description Stop TV.

# @raycast.icon images/apple-tv-logo.png
# @raycast.mode silent
# @raycast.packageName TV
# @raycast.schemaVersion 1

tell application "TV"
	stop
end tell

do shell script "echo Stopped TV"