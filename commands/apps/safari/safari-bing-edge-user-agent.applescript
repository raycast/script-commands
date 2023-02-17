#!/usr/bin/osascript
# Check "Safari > Advanced > Develop" first.
# This script works on the English Safari menu.

# @raycast.title Open Bing with Edge User-Agent
# @raycast.description Open Bing in Safari with Edge User-Agent
# @raycast.author smxl
# @raycast.authorURL https://github.com/smxl

# @raycast.icon images/safari.png
# @raycast.mode silent
# @raycast.packageName Safari
# @raycast.schemaVersion 1

tell application "Safari"
	activate
	set theURL to "https://www.bing.com"
	set newTab to make new tab at end of tabs of window 1
	set current tab of window 1 to newTab
	set theUserAgent to "Microsoft Edge ¡ª MacOS"
	set URL of newTab to theURL
	tell application "System Events"
		tell process "Safari"
			click menu item theUserAgent of menu "User Agent" of menu item "User Agent" of menu "Develop" of menu bar 1
		end tell
	end tell
end tell