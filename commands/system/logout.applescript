#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Log out
# @raycast.mode compact

# Optional parameters:
# @raycast.icon 🚪
# @raycast.needsConfirmation true

# Documentation:
# @raycast.description Log out from MacOS session 
# @raycast.author vadym_ozarynskyi
# @raycast.authorURL https://github.com/VadimOza

tell application "System Events" to log out

