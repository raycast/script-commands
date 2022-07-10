#!/usr/bin/osascript

# You need ExpressVPN for this script: https://www.expressvpn.com/latest#mac

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title ExpressVPN Disconnect
# @raycast.mode silent

# Optional parameters:
# @raycast.icon images/expressvpn_logo.svg
# @raycast.packageName ExpressVPN

# Documentation:
# @raycast.author Amir Hossein SamadiPour
# @raycast.authorURL https://github.com/SamadiPour

tell application "ExpressVPN"
	if state = "connected" or state = "connecting" then
		disconnect
	else if state = "ready" then
		do shell script "echo Already Disconnected..."
	end if
end tell
