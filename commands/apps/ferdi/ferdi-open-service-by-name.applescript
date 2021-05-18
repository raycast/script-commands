#!/usr/bin/osascript

# Dependency: This script requires Ferdi to be installed: https://getferdi.com/

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Open Service by Name
# @raycast.mode silent

# Optional parameters:
# @raycast.icon images/ferdi.png
# @raycast.packageName Ferdi
# @raycast.argument1 { "type": "text", "placeholder": "Name", "optional": true }

# Documentation:
# @raycast.author Jakub Lanski
# @raycast.authorURL https://github.com/jaklan

on run argv
	
	### Configuration ###
	
	# Delay time before triggering the click (used only when Ferdi needs to be initialised)
	set clickDelay to 5
	
	### End of configuration ###
	
	if application "Ferdi" is running then
		do shell script "open -a Ferdi"
	else
		do shell script "open -a Ferdi"
		delay clickDelay
	end if
	
	tell application "System Events" to tell process "Ferdi"
		set menuItems to name of menu items of menu 1 of menu bar item "Services" of menu bar 1
		set menuItems to items 7 through end of menuItems
		
		if item 1 of argv = "" then
			click menu item 7 of menu 1 of menu bar item "Services" of menu bar 1
		else
			repeat with i from 1 to (count menuItems)
				if item i of menuItems contains item 1 of argv then
					click menu item (6 + i) of menu 1 of menu bar item "Services" of menu bar 1
					exit repeat
				end if
			end repeat
		end if
	end tell
	
end run
