#!/usr/bin/osascript

# @raycast.schemaVersion 1
# @raycast.title Refresh Wallpaper
# @raycast.mode silent
# @raycast.author Caleb Stauffer
# @raycast.authorURL https://github.com/crstauf
# @raycast.description Refresh the current display's wallpaper
# @raycast.icon 🖼️
# @raycast.packageName System

tell application "System Events"
	set rotinterval to change interval of current desktop
	set change interval of current desktop to rotinterval
end tell

do shell script "echo Refreshed wallpaper"