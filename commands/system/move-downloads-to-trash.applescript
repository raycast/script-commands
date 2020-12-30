#!/usr/bin/osascript

# Required parameters:
# @raycast.author Jax0rz
# @authorURL https://github.com/Jax0rz
# @raycast.schemaVersion 1
# @raycast.title Move Downloads to Trash
# @raycast.mode silent
# @raycast.packageName System
# @raycast.needsConfirmation true

# Optional parameters:
# @raycast.icon images/move-downloads-to-trash.png

tell application "Finder"
   set allDownloads to every item of folder (path to downloads folder as text)
   move allDownloads to trash
   log ""
end tell
