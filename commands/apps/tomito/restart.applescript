#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Restart the current activity
# @raycast.mode silent

# Optional parameters:
# @raycast.icon images/tomito-logo.png
# @raycast.packageName Tomito

# Documentation:
# @raycast.author Achille Lacoin
# @raycast.authorURL https://github.com/pomdtr

tell application "Tomito"
	restart
end tell
