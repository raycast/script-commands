#!/usr/bin/osascript

# Required parameters:
# @raycast.author Jax0rz
# @authorURL https://github.com/Jax0rz
# @raycast.schemaVersion 1
# @raycast.title Trash Downloads
# @raycast.mode silent

# Optional parameters:
# @raycast.icon images/trash-downloads.png

set downloadsFolder to (path to downloads folder)
set allItems to list folder downloadsFolder without invisibles

repeat with i in allItems
   set myItem to (downloadsFolder as text) & i
   do shell script "rm -fR " & quoted form of (POSIX path of myItem)
end repeat