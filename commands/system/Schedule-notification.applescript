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
# @raycast.description Simple minutes countdown
# @raycast.author Marco Cebrian Muino
# @raycast.authorURL https://github.com/marcocebrian

on run argv
	set theTime to (item 1 of argv as integer) * 60
	set theTitle to item 2 of argv as string
	
	if length of theTitle < 1 then
		set theTitle to "Time is over!"
	end if
	do shell script "echo Scheduled notification $theTitle after $theTime minutes."
	delay theTime
	
	display notification "Your countdown of " & theTime & " minutes is over." with title theTitle sound name "Jump"
	#display alert "Time is over!" message "Your countdown of " & theTime & " minutes is over." as informational buttons {"Ok"} default button "Ok"
end run

