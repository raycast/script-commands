#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Close Last Tab
# @raycast.mode silent

# Optional parameters:
# @raycast.icon images/menubarx_logo.png
# @raycast.packageName MenubarX

# Documentation:
# @raycast.description Close last viewed tab in MenubarX
# @raycast.author Clu Soh
# @raycast.authorURL https://twitter.com/designedbyclu

tell application "MenubarX" to activate
delay 0.1
tell application "System Events" to tell process "MenubarX"
	key code 13 using {shift down, command down}
end tell
do shell script "echo Closed tab"