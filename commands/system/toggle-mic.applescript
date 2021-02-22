#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Toggle Microphone
# @raycast.mode silent
# @raycast.packageName System

# Optional parameters:
# @raycast.icon 🎙

# Documentation:
# @raycast.author Matthew Morek
# @raycast.authorURL https://github.com/matthewmorek
# @raycast.description Toggles microphone.


on getMicrophoneVolume()
	input volume of (get volume settings)
end getMicrophoneVolume
on disableMicrophone()
	set volume input volume 0
	log "Microphone turned off 🔴"
end disableMicrophone
on enableMicrophone()
	set volume input volume 100
	log "Microphone turned on 🟢"
end enableMicrophone

if getMicrophoneVolume() is greater than 0 then
	disableMicrophone()
else
	enableMicrophone()
end if
