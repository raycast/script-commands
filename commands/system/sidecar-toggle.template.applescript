#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Sidecar Switch
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🖥
# @raycast.packageName System

# Documentation:
# @raycast.description Toggles on/off a Sidecar screen.
# @raycast.author Marcos Sánchez-Dehesa
# @raycast.authorURL https://www.github.com/dehesa

# The name of the device to be connected as a sidecar screen.
# You can figure out the exact device's name by clicking the "Control Center" item in the menu bar > Displays; and then see all available devices under "Connect to:"
property deviceName : "Honiara"
# Change these button titles to whatever is called in your OS language.
property connectName : "Connect to Sidecar"
property disconnectName : "Disconnect"

tell application "System Events"
	tell process "ControlCenter"
		try
			perform action "AXPress" of menu bar item "Control Center" of first menu bar
		on error
			tell me to error "For this script to work you need to be in macOS 11+ and have Control Center in the menu bar"
		end try
		
		if checkbox connectName of first window exists then
			perform action "AXPress" of checkbox connectName of first window
			delay 0.5
			
			set elements to entire contents of first window
			repeat with elem in elements
				if (exists attribute "AXTitle" of elem) and (value of attribute "AXTitle" of elem contains deviceName) then
					perform action "AXPress" of elem
					do shell script "echo Connection established to " & deviceName
					return
				end if
			end repeat
			tell me to error "Connect Sidecar was not found"
		end if
		
		set elements to entire contents of first window
		repeat with elem in elements
			if exists attribute "AXTitle" of elem then
				set elTitle to value of attribute "AXTitle" of elem
				if (elTitle contains disconnectName) and (elTitle contains deviceName) then
					perform action "AXPress" of elem
					do shell script "echo " & deviceName & " was disconnected"
					return
				end if
			end if
		end repeat
		
		tell me to error "Disconnect Sidecar was not found"
	end tell
end tell