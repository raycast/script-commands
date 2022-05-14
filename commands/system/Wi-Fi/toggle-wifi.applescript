#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Toggle WiFi
# @raycast.mode silent

# Optional parameters:
# @raycast.icon images/toggle-wifi.png
# @raycast.packageName System

# Documentation:
# @raycast.description Enable or Disable Wi-Fi on your macOS
# @raycast.author pradeepb28
# @raycast.authorURL https://twitter.com/pradeepb28

try
	set status to do shell script "networksetup -getairportpower en0"
	if status ends with "On" then
		do shell script "networksetup -setairportpower en0 off"
		log "Wi-Fi turned off"
	else
		do shell script "networksetup -setairportpower en0 on"
		log "Wi-Fi turned on"
	end if
end try