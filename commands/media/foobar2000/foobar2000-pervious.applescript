#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Previous foobar2000
# @raycast.mode silent

# Optional parameters:
# @raycast.icon images/foobar2000.png
# @raycast.packageName foobar2000

# Documentation:
# @raycast.description Shortcuts to Previous foobar2000 for Mac v2.3.0
# @raycast.author Jing Li
# @raycast.authorURL https://github.com/lixeon

tell application "System Events"
    tell process "foobar2000" 
	    click menu item "Previous" of menu "Playback" of menu bar item "Playback" of menu bar 1
    end tell
end tell

