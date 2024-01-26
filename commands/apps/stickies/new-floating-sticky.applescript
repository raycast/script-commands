#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title New Floating Sticky Note
# @raycast.mode silent
# @raycast.packageName Stickies

# Optional parameters:
# @raycast.icon images/stickies.png

# Documentation:
# @raycast.description This script creates a new floating note in the Apple Stickies application
# @raycast.author Annie Ma
# @raycast.authorURL http://www.anniema.co/

tell application "Stickies"
	activate
	tell application "System Events"
		keystroke "n" using command down
		keystroke "f" using command down & option down
	end tell
end tell