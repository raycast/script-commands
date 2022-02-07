#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Denon AVR - Power On
# @raycast.mode compact

# Optional parameters:
# @raycast.icon 🟢

# Documentation:
# @raycast.description Powers on a modern Denon AVR if it is currently powered off
# @raycast.author Rediwed
# @raycast.authorURL github.com/Rediwed

on run
	set ip_address to (do shell script "defaults read com.Rediwed.DenonAVR ip_address")
	if (do shell script "defaults read com.Rediwed.DenonAVR method") = "modern" then
		runModern(ip_address)
	else
		runClassic(ip_address)
	end if
end run

on runModern(ip_address)
	do shell script "curl " & ip_address & ":8080/goform/formiPhoneAppDirect.xml?PWON"
	Log "Powering on..."
end runModern

on runClassic(ip_address)
	#classic is not yet set-up
	#do shell script "curl 192.168.0.214:8080//goform/formiPhoneAppDirect.xml?MV" & (item 1 of argv)
	log "Classic has not yet been set-up"
end runClassic
