#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Capture Screen Selection to Desktop
# @raycast.mode silent
# @raycast.packageName System
#
# Optional parameters:
# @raycast.icon 💻
#
# Documentation:
# @raycast.description This script screenshots the selected area and saves it to the desktop.
# @raycast.author Aaron Miller
# @raycast.authorURL https://github.com/aaronhmiller

tell application "System Events" to key code 21 using {shift down, command down}
