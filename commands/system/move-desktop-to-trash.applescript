#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Move Desktop to Trash
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🗑
# @raycast.packageName System
# @raycast.needsConfirmation true

# Documentation:
# @raycast.author Seypopi
# @raycast.authorURL https://github.com/Seypopi
# @raycast.description Empty the desktop.

tell application "Finder"
    set allDesktop to every item of folder (path to Desktop folder as text)
    move allDesktop to trash
    log ""
end tell
