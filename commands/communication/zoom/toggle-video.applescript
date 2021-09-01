#!/usr/bin/osascript

# Required parameters:
# @raycast.author Luigi Cardito
# @raycast.authorURL https://github.com/lcardito
# @raycast.author Faris Aziz
# @raycast.authorURL https://github.com/farisaziz12
# @raycast.schemaVersion 1
# @raycast.title Toggle Video
# @raycast.mode silent
# @raycast.packageName Zoom
# @raycast.description Show/Hide your microphone in the current meeting


# Optional parameters:
# @raycast.icon images/zoom-logo.png


tell application "zoom.us"
	activate
	tell application "System Events"
		keystroke "v" using {shift down, command down}
		log "Toggle video"
	end tell
end tell
