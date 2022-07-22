#!/usr/bin/osascript

# You need ExpressVPN for this script: https://www.expressvpn.com/latest#mac

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Reconnect
# @raycast.mode silent

# Optional parameters:
# @raycast.icon images/expressvpn_logo.svg
# @raycast.packageName ExpressVPN

# Documentation:
# @raycast.author Amir Hossein SamadiPour
# @raycast.authorURL https://github.com/SamadiPour

tell application "ExpressVPN"
	if state = "connected" and not (state = "connecting") then
		disconnect
		delay 0.5
		connect
	else if state = "ready" then
		connect
	end if
end tell
do shell script "echo Reconnecting..."
