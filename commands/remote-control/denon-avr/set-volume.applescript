#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Set Volume
# @raycast.mode compact

# Optional parameters:
# @raycast.icon images/denon_logo.png
# @raycast.argument1 { "type": "text", "placeholder": "Placeholder" }
# @raycast.packageName Denon AVR

# Documentation:
# @raycast.description Sets the Denon AVR to a specific volume level (between 0 and 80)
# @raycast.author Rediwed
# @raycast.authorURL github.com/Rediwed

on run argv
	if 0 ² (item 1 of argv) and (item 1 of argv) ² 80 then
		set ip_address to (do shell script "defaults read com.Rediwed.DenonAVR ip_address")
		if (do shell script "defaults read com.Rediwed.DenonAVR method") = "modern" then
			runModern(ip_address, item 1 of argv)
		else
			runClassic(ip_address, item 1 of argv)
		end if
	else
		log "Command not executed, illegal volume!"
	end if
end run

on runModern(ip_address, volume_level)
	do shell script "curl " & ip_address & ":8080//goform/formiPhoneAppDirect.xml?MV" & (volume_level)
	log "Volume set to " & volume_level & "!"
end runModern

on runClassic(ip_address, volume_level)
	#classic is not yet set-up
	#do shell script "curl 192.168.0.214:8080//goform/formiPhoneAppDirect.xml?MV" & (item 1 of argv)
	log "Classic has not yet been set-up"
end runClassic
