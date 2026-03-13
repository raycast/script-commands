#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Toggle Menu Bar Visibility
# @raycast.mode silent

# Optional parameters:
# @raycast.packageName Toggle Menu Bar Visibility

# Documentation:
# @raycast.description Toggles the visibility of the menubar.
# @raycast.author Connor Forsyth
# @raycast.authorURL https://raycast.com/connorforsyth


tell application "System Events"
	tell dock preferences
		set autohide menu bar to not autohide menu bar
	end tell
end tell
