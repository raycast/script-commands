#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Minimize all windows
# @raycast.mode silent

# Optional parameters:
# @raycast.icon images/minimize-window.png
# @raycast.packageName Finder
# Documentation:
# @raycast.author Ernest Ojeh
# @raycast.authorURL https://github.com/namzo
# @raycast.description Minimize all windows

tell application "System Events"
    keystroke "hm" using {command down, option down}
end tell