#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Schedule notification
# @raycast.mode silent
# @raycast.packageName System

# Optional parameters:
# @raycast.icon images/clock.png
# @raycast.argument1 { "type": "text", "placeholder": "In Minutes" }
# @raycast.argument2 { "type": "text", "placeholder": "Title", "optional": true }


# @Documentation:
# @raycast.description Simple scheduler for Mac Os X notifications after x amount of minutes with a configurable title.
# @raycast.author Marco Cebrian Muino
# @raycast.authorURL https://github.com/marcocebrian


on run argv
	set theTime to (item 1 of argv as integer) * 60
	set theTitle to item 2 of argv as string
	
	set minutes to (theTime / 60) as integer
	
	if minutes = 1 then
		set timeString to " minute"
	else
		set timeString to " minutes"
	end if
	
	if length of theTitle < 1 then
		set theTitle to "Time is over!"
	end if
	
	log "Scheduled notification " & theTitle & " after " & minutes & timeString
	
	delay theTime
	display notification "Your countdown of " & ((theTime / 60) as integer) & timeString & " is over." with title theTitle sound name "Jump"
	
	#If you prefer an alert. Comment the line "display notification..." and uncomment the "#display alert..." line
	#display alert "Time is over!" message "Your countdown of " &  ((theTime / 60) as integer) & " minutes is over." as informational buttons {"Ok"} default button "Ok"
end run

