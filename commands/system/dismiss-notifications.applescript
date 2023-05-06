#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Dismiss Notifications
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🔕
# @raycast.packageName System

# Documentation:
# @raycast.description Close all notification alerts staying on screen, e.g., Calendar notifications.
# @raycast.author benyn
# @raycast.authorURL github.com/benyn

tell application "System Events"
	tell process "NotificationCenter"
		if not (window "Notification Center" exists) then return
		set alertGroups to groups of first UI element of first scroll area of first group of window "Notification Center"
		repeat with aGroup in alertGroups
			try
				perform (first action of aGroup whose name contains "Close" or name contains "Clear")
			on error errMsg
				log errMsg
			end try
		end repeat
		-- Show no message on success
		return ""
	end tell
end tell
