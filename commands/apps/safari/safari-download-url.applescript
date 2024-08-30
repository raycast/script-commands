#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Download Current URL
# @raycast.mode silent

# Optional parameters:
# @raycast.packageName Safari
# @raycast.icon images/safari.png

# @Documentation:
# @raycast.author Michael Bianco
# @raycast.authorURL https://github.com/iloveitaly
# @raycast.description Download the currently active tab's URL.

tell application "Safari"
	activate
	set currentTab to current tab of window 1
	set theURL to URL of currentTab
end tell

-- Simulate pressing Option key and clicking the link
tell application "System Events"
	keystroke "l" using {command down} -- Select the address bar (Cmd + L)
	delay 0.5
	keystroke return using {option down} -- Press Option + Return to download the file
end tell
