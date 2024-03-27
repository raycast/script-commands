#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Show Notifications
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🔕
# @raycast.packageName System

# Documentation:
# @raycast.description Show all notification of the first alert group
# @raycast.author iloveitaly
# @raycast.authorURL github.com/iloveitaly

tell application "System Events"
	tell process "NotificationCenter"
		if not (window "Notification Center" exists) then return
		-- clicking on the notification group will expand it and show all sub messages
		click of group 1 of UI element of scroll area of first group of window "Notification Center"
		-- Show no message on success
		return ""
	end tell
end tell