#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Capture Screen Selection to Clipboard
# @raycast.mode silent
# @raycast.packageName System
#
# Optional parameters:
# @raycast.icon 💻
#
# Documentation:
# @raycast.description This script screenshots the selected area and saves it to the clipboard.
# @raycast.author Aaron Miller
# @raycast.authorURL https://github.com/aaronhmiller

tell application "System Events" to key code 21 using {control down, shift down, command down}
