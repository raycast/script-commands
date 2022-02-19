#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Configure
# @raycast.mode compact

# Optional parameters:
# @raycast.icon images/denon_logo.png
# @raycast.argument1 { "type": "text", "placeholder": "Denon AVR IP" }
# @raycast.argument2 { "type": "text", "placeholder": "Method (Classic or Modern)" }
# @raycast.packageName Denon AVR

# Documentation:
# @raycast.description Helperscript to configure Denon AVR Script Commands
# @raycast.author Rediwed
# @raycast.authorURL github.com/Rediwed

on run argv
	try
		checkAlive(item 1 of argv)
		writeIP(item 1 of argv)
		setMethod(item 2 of argv)
		log "Configuration success!"
	on error err_msg
		tell me to error "An error has occured: " & err_msg
	end try
end run

on checkAlive(ip_address)
	try
		do shell script "ping -c 1 " & ip_address
	on error
		tell me to error "Ip-address " & ip_address & " is incorrect, please adjust"
	end try
end checkAlive

on writeIP(ip_address)
	do shell script "defaults write com.Rediwed.DenonAVR ip_address " & ip_address
	return
end writeIP

on setMethod(Method)
	set Method to (do shell script "echo " & (quoted form of Method) & " | tr '[:upper:]' '[:lower:]'")
	do shell script "defaults write com.Rediwed.DenonAVR method " & Method
end setMethod
