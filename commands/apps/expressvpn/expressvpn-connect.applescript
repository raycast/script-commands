#!/usr/bin/osascript

# You need ExpressVPN for this script: https://www.expressvpn.com/latest#mac

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Connect
# @raycast.mode silent

# Optional parameters:
# @raycast.icon images/expressvpn_logo.svg
# @raycast.packageName ExpressVPN

# Documentation:
# @raycast.author Amir Hossein SamadiPour
# @raycast.authorURL https://github.com/SamadiPour

tell application "ExpressVPN"
	if state = "connected" then
		do shell script "echo Already Connected."
	else if state = "connecting" then
		do shell script "echo Please wait. Connecting..."
	else if state = "ready" then
		connect
	end if
end tell
