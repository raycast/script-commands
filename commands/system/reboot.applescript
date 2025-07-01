#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Reboot
# @raycast.mode compact

# Optional parameters:
# @raycast.icon 🔁
# @raycast.needsConfirmation true

# Documentation:
# @raycast.description Reboot your OS
# @raycast.author vadym_ozarynskyi
# @raycast.authorURL https://github.com/VadimOza

tell application "System Events" to restart
