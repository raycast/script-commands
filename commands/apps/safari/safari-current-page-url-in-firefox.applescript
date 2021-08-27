#!/usr/bin/osascript

# @raycast.title Open Safari URL in Firefox
# @raycast.description Open current Safari URL in new tab in Firefox
# @raycast.author Dave Lehman
# @raycast.authorURL https://github.com/dlehman

# @raycast.icon images/safari.png
# @raycast.mode silent
# @raycast.packageName Safari
# @raycast.schemaVersion 1

tell application "Safari"
	set safariUrl to URL of front document
end tell

tell application "Firefox"
	activate
	delay 0.5
	open location safariUrl
	activate
end tell
