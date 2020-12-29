#!/usr/bin/osascript

# Required parameters:
# @raycast.author Jax0rz
# @authorURL https://github.com/Jax0rz
# @raycast.schemaVersion 1
# @raycast.title Trash Downloads
# @raycast.mode silent
# @raycast.packageName Navigation

# Optional parameters:
# @raycast.icon images/trash-downloads.png

tell application "Finder"
   set allDownloads to every item of folder (path to downloads folder as text)
   move allDownloads to trash
end tell