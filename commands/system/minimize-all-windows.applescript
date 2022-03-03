#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Minimize All Windows
# @raycast.mode silent

# Optional parameters:
# @raycast.icon images/minimize-window.png
# @raycast.packageName System
# Documentation:
# @raycast.author Ernest Ojeh
# @raycast.authorURL https://github.com/namzo
# @raycast.description This script minimizes all windows of currently running apps

tell application "System Events"
    keystroke "hm" using {command down, option down}
end tell