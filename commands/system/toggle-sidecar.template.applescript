#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Toggle Sidecar
# @raycast.mode silent

# Optional parameters:
# @raycast.icon images/apple_sidecar.png
# @raycast.packageName System

# Documentation:
# @raycast.description Toggles on/off a Sidecar screen.
# @raycast.author Marcos S‡nchez-Dehesa
# @raycast.authorURL https://www.github.com/dehesa

# The name of the device to be connected as a sidecar screen (e.g. the name of your iPad).
# You can figure out the exact device's name by going to System Preferences > Displays > Add Display.
set displayName to "Honiara"
# If your system is not in English, you should change this text to text display in the pop up menu item in System Preferences > Displays > Add Display.
set menuItemName to "Add Display"
# The System Preferences > Displays screen takes a long time to load (I don't know why). This delay waits for the screen to properly load. Your system may need less or more seconds. Do some trial and errors.
set delayInSeconds to 1.8

tell application "System Preferences"
	activate
	set current pane to pane id "com.apple.preference.displays"
	
	delay delayInSeconds
	
	tell application "System Events"
		tell first window of application process "System Preferences"
			tell pop up button menuItemName
				click
				click menu item displayName of menu menuItemName
			end tell
		end tell
	end tell
	
	quit
end tell
