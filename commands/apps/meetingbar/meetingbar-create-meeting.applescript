#!/usr/bin/osascript

# Dependencies:
# MeetingBar: https://github.com/leits/MeetingBar

# Recommended installation:
# brew install --cask meetingbar

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Create Meeting
# @raycast.mode silent

# Optional parameters:
# @raycast.icon images/meetingbar.png
# @raycast.packageName MeetingBar

# Documentation:
# @raycast.author Jakub Lanski
# @raycast.authorURL https://github.com/jaklan
# @raycast.description Create a new meeting.

on run
	
	try
		runMeetingBar()
		createMeeting()
		return
		
	on error errorMessage
		closeMenu()
		return errorMessage
		
	end try
	
end run

### Functions ###

on createMeeting()
	openMenu()
	tell application "System Events" to tell application process "MeetingBar"
		tell menu 1 of menu bar item 1 of menu bar 2
			click menu item "Create meeting"
		end tell
	end tell
end createMeeting

on MeetingBarIsRunning()
	return application "MeetingBar" is running
end MeetingBarIsRunning

on runMeetingBar()
	if not MeetingBarIsRunning() then do shell script "open -a 'MeetingBar'"
end runMeetingBar

on menuIsOpen()
	tell application "System Events" to tell application process "MeetingBar"
		return menu 1 of menu bar item 1 of menu bar 2 exists
	end tell
end menuIsOpen

on openMenu()
	set killDelay to 0
	repeat
		tell application "System Events" to tell application process "MeetingBar"
			if my menuIsOpen() then return
			ignoring application responses
				click menu bar item 1 of menu bar 2
			end ignoring
		end tell
		set killDelay to killDelay + 0.1
		delay killDelay
		do shell script "killall System\\ Events"
	end repeat
end openMenu

on closeMenu()
	if menuIsOpen() then tell application "System Events" to key code 53
end closeMenu