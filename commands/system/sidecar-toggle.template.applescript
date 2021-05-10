#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Toggle Sidecar
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🖥
# @raycast.packageName System

# Documentation:
# @raycast.description Toggles a Sidecar screen.
# @raycast.author Marcos Sánchez-Dehesa
# @raycast.authorURL https://www.github.com/dehesa

# You can see your device's name by going to: System Preferences > Sidecar > Connect to menu
property deviceName : "Your device's name"
# The button name changes depending on your locale.
property buttonName : "Disconnect"

tell application "System Preferences"
	activate
	reveal pane id "com.apple.preference.sidecar"
	delay 0.9
	
	try
		tell application "System Events" to click button buttonName of first window of application process "System Preferences" of application "System Events"
	on error
		tell application "System Events" to click first menu button of first window of application process "System Preferences" of application "System Events"
		# If your sidecar screen device changes, youc can change the "click menu item deviceName" by "click first menu item"
		tell application "System Events" to click menu item deviceName of first menu of first menu button of first window of application process "System Preferences" of application "System Events"
	end try

	quit
	
end tell