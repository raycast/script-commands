#!/usr/bin/osascript

# @raycast.title Refresh Wallpaper
# @raycast.author Caleb Stauffer
# @raycast.authorURL https://github.com/crstauf
# @raycast.description Apply a random image from the [wallpaper directory](https://support.apple.com/guide/mac-help/change-your-desktop-picture-mchlp3013/mac) for the main display's current [Space](https://support.apple.com/guide/mac-help/work-in-multiple-spaces-mh14112/mac).

# @raycast.icon 🖼️
# @raycast.mode silent
# @raycast.packageName System
# @raycast.schemaVersion 1

tell application "System Events"
	set rotinterval to change interval of current desktop
	set change interval of current desktop to rotinterval
end tell

do shell script "echo Refreshed wallpaper"
