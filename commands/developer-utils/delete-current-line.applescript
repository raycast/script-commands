#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Delete Current Line
# @raycast.mode silent
# @raycast.packageName Developer Utilities

# Optional parameters:
# @raycast.icon ⌨️

# Documentation:
# @raycast.description This script deletes the line at cursor position.
# @raycast.author Annie Ma
# @raycast.authorURL http://www.anniema.co/

tell application "System Events"
    keystroke "k" using control down
    keystroke (ASCII character 8) using command down
end tell
