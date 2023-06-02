#!/usr/bin/osascript

# Note: Bartender 4 required
# Install from https://www.macbartender.com/

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Search Bartender
# @raycast.mode silent

# Optional parameters:
# @raycast.icon images/bartender-icon.png
# @raycast.argument1 { "type": "text", "placeholder": "Menu Bar Item Name" }
# @raycast.packageName Bartender.app

# Documentation:
# @raycast.description Perform a quick search of Menu Bar Items, in Bartender 4

on run argv
	tell application "Bartender 4"
	    quick search with argv
	end tell
end run			