#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Screen Saver
# @raycast.mode silent
# @raycast.packageName System

# Optional parameters:
# @raycast.icon 🌀
# @raycast.author Valentin Chrétien
# @raycast.authorURL https://twitter.com/valentinchrt
# @raycast.description A script command to start your current screen saver.

tell application "System Events" 
    start current screen saver
end tell