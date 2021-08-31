#!/usr/bin/osascript

# Required parameters:
# @raycast.author Luigi Cardito
# @raycast.authorURL https://github.com/lcardito
# @raycast.author Faris Aziz
# @raycast.authorURL https://github.com/farisaziz12
# @raycast.schemaVersion 1
# @raycast.title Mute microphone
# @raycast.mode silent
# @raycast.packageName Zoom
# @raycast.description Mutes your microphone in the current meetin
# @raycast.needsConfirmation false


# Optional parameters:
# @raycast.icon images/zoom-logo.png


tell application "zoom.us"
	activate
	tell application "System Events"
		keystroke "a" using {shift down, command down}
		log "Toggle mute"
	end tell
end tell
