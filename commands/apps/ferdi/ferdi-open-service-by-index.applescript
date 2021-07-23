#!/usr/bin/osascript

# Dependency: This script requires Ferdi to be installed: https://getferdi.com/

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Open Service by Index
# @raycast.mode silent

# Optional parameters:
# @raycast.icon images/ferdi.png
# @raycast.packageName Ferdi
# @raycast.argument1 { "type": "text", "placeholder": "Index", "optional": true }

# Documentation:
# @raycast.author Jakub Lanski
# @raycast.authorURL https://github.com/jaklan

on run argv

	### Configuration ###

	# Delay time before triggering the keystroke (used only when Ferdi needs to be initialized)
	set keystrokeDelay to 5

	### End of configuration ###

	if item 1 of argv = "" then
		set serviceIndex to 1
	else
		set serviceIndex to item 1 of argv
	end if

	if application "Ferdi" is running then
		do shell script "open -a Ferdi"
	else
		do shell script "open -a Ferdi"
		delay keystrokeDelay
	end if

	tell application "System Events" to keystroke serviceIndex using command down

end run
