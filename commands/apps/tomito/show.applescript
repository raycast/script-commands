#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Show Tomito's main window
# @raycast.mode silent

# Optional parameters:
# @raycast.icon images/tomito-logo.png
# @raycast.packageName Tomito

# Documentation:
# @raycast.author Achille Lacoin
# @raycast.authorURL https://github.com/pomdtr

tell application "Tomito"
	launch
	show
end tell
