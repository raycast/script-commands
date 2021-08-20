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

# You can figure out your device's name on System Preferences > Sidecar > Connect to menu
property deviceName : "Device name"
# Change the "Disconnect" value if your OS is in a different language than English
property buttonName : "Disconnect"

property isConnected : false

tell application "System Preferences"
	activate
	reveal pane id "com.apple.preference.sidecar"
	delay 0.9
	
	try
		tell application "System Events" to click button buttonName of first window of application process "System Preferences" of application "System Events"
	on error
		tell application "System Events" to click first menu button of first window of application process "System Preferences" of application "System Events"
		# If your sidecar screen device changes, you can change the "click menu item deviceName" by "click first menu item"
		tell application "System Events" to click menu item deviceName of first menu of first menu button of first window of application process "System Preferences" of application "System Events"
		set isConnected to true
	end try

	quit	
end tell

if isConnected  then
	do shell script "echo Connection established to " & deviceName
else
	do shell script "echo " & deviceName & " was disconnected"
end if
