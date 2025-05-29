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

tell application "System Events" to tell process "NotificationCenter"
	-- Exit if there are no visible notifications.
	if not (window "Notification Center" exists) then return

	-- `notificationContainer` refers to the UI element (of class `group`) holding notifications and can be either:
	-- - A single, individual notification, or
	-- - A collection of individual notifications and groups of stacked notifications.
	set notificationContainer to a reference to group 1 of scroll area 1 of group 1 of group 1 of window "Notification Center"

	-- If it is a collection, close notifications and groups in reverse order to avoid index changes.
	set notificationGroups to a reference to groups of notificationContainer
	repeat with i from (number of notificationGroups) to 1 by -1
		set g to item i of notificationGroups
		repeat with a in (actions of g whose description is "Close" or description starts with "Clear")
			-- Ignore errors that happen if the last remaining item is an individual notification,
			-- and `notificationCenter` is no longer a `group` of `group`s.
			-- The final remaining notification will be closed in the second repeat statement below.
			ignoring application responses
				perform a
			end ignoring
		end repeat
	end repeat

	-- Close the `notificationContainer` itself. This handles:
	-- - A single, individual notification that was `notificationContainer` from the start, or
	-- - The last remaining individual notification after the loop above.
	repeat with a in (actions of notificationContainer whose description is "Close" or description starts with "Clear")
		perform a
	end repeat
end tell

-- Prevent Raycast from displaying the successful result message.
return
