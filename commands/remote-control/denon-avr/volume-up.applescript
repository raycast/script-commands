#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Volume Up
# @raycast.mode compact

# Optional parameters:
# @raycast.icon images/denon_logo.png
# @raycast.packageName Denon AVR

# Documentation:
# @raycast.description Increases the volume of your Denon AVR by one unit
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
	do shell script "curl " & ip_address & ":8080/goform/formiPhoneAppDirect.xml?MVUP"
	log "Volume increased!"
end runModern

on runClassic(ip_address)
	#classic is not yet set-up
	#do shell script "curl 192.168.0.214:8080//goform/formiPhoneAppDirect.xml?MV" & (item 1 of argv)
	log "Classic has not yet been set-up"
end runClassic
