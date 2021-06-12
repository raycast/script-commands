#!/usr/bin/osascript

# Dependencies:
# Pulse Secure: https://www.pulsesecure.net/

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Suspend
# @raycast.mode silent

# Optional parameters:
# @raycast.packageName Pulse Secure
# @raycast.icon images/pulse-secure.png

# Documentation:
# @raycast.author Jakub Lanski
# @raycast.authorURL https://github.com/jaklan
# @raycast.description Suspend the active connection.

on run argv
	
	### End of configuration ###
	
	try
		if not trayIsRunning() then error "Pulse Secure tray is not running"
		
		suspend()
		return
		
	on error errorMessage
		closeMenu()
		return errorMessage
		
	end try
	
end run

### Functions ###

on suspend()
	openMenu()
	tell application "System Events" to tell process "PulseTray"
		tell menu 1 of menu bar item 1 of menu bar 2
			if name of menu item 3 contains "Connected" then
				tell (first menu item whose value of attribute "AXMenuItemMarkChar" is " ")
					click
					tell menu 1
						if value of attribute "AXEnabled" of menu item "Suspend" then
							click menu item "Suspend"
						else
							error "Menu item \"Suspend\" is not active"
						end if
					end tell
				end tell
			else
				error "No active connection"
			end if
		end tell
	end tell
end suspend

on trayIsRunning()
	return application "PulseTray" is running
end trayIsRunning

on menuIsOpen()
	tell application "System Events" to tell process "PulseTray"
		return menu 1 of menu bar item 1 of menu bar 2 exists
	end tell
end menuIsOpen

on openMenu()
	set killDelay to 0
	repeat
		tell application "System Events" to tell process "PulseTray"
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
