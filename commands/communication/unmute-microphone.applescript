#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Un/Mute Microphone
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🎙

# Documentation:
# @raycast.description Un/Mute Microphone Globally
# @raycast.author osrecio
# @raycast.authorURL https://twitter.com/osrecio

set inputVolume to input volume of (get volume settings)
if inputVolume = 0 then
	set inputVolume to 100
	log "✅ Microphone is on"
else
	set inputVolume to 0
	log "❌ Microphone is off"
end if
set volume input volume inputVolume

