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
# @raycast.author dlvhdr
# @raycast.authorURL github.com/dlvhdr

tell application "System Events" to tell application process "NotificationCenter"
	try
		repeat with uiElement in (actions of UI elements of scroll area 1 of group 1 of group 1 of window "Notification Center" of application process "NotificationCenter" of application "System Events")
			if description of uiElement contains "Close" then
				perform uiElement
			end if
			if description of uiElement contains "Clear" then
				perform uiElement
			end if
		end repeat
    return ""
	end try
end tell
