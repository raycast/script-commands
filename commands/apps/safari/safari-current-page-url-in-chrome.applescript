#!/usr/bin/osascript

# @raycast.title Open Safari URL in Chrome
# @raycast.description Open current Safari URL in new tab in Chrome
# @raycast.author Dave Lehman
# @raycast.authorURL https://github.com/dlehman

# @raycast.icon images/safari.png
# @raycast.mode silent
# @raycast.packageName Safari
# @raycast.schemaVersion 1

tell application "Safari"
	set safariUrl to URL of front document
end tell

tell application "Google Chrome"
	activate
	delay 0.5
	tell front window to make new tab at after (get active tab) with properties {URL:safariUrl} -- open a new tab after the current tab
	activate
end tell
