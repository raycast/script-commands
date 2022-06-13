#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Open Tabs
# @raycast.mode silent

# Optional parameters:
# @raycast.icon images/menubarx_logo.png
# @raycast.packageName MenubarX
# @raycast.argument1 { "type": "text", "placeholder": "Tabs 1~9" }

# Documentation:
# @raycast.description Open X Tab in your menubar
# @raycast.author Clu Soh
# @raycast.authorURL https://twitter.com/designedbyclu


on run argv
		set tabNum to item 1 of argv

	 if tabNum is equal to "1" then
		tell application "MenubarX" to activate
			delay 0.1
				tell application "System Events" to tell process "MenubarX"
				keystroke "1" using command down
		end tell
	else  if tabNum is equal to "2" then
		tell application "MenubarX" to activate
		delay 0.1
		tell application "System Events" to tell process "MenubarX"
			keystroke "2" using command down
		end tell
	else  if tabNum is equal to "3" then
		tell application "MenubarX" to activate
		delay 0.1
		tell application "System Events" to tell process "MenubarX"
			keystroke "3" using command down
		end tell
	else if tabNum is equal to "4" then
		tell application "MenubarX" to activate
		delay 0.1
		tell application "System Events" to tell process "MenubarX"
			keystroke "4" using command down
		end tell
	else  if tabNum is equal to "5" then
		tell application "MenubarX" to activate
		delay 0.1
		tell application "System Events" to tell process "MenubarX"
			keystroke "5" using command down
		end tell
	else  if tabNum is equal to "6" then
		tell application "MenubarX" to activate
		delay 0.1
			tell application "System Events" to tell process "MenubarX"
			keystroke "6" using command down
		end tell
	else if tabNum is equal to "7" then
		tell application "MenubarX" to activate
		delay 0.1
		tell application "System Events" to tell process "MenubarX"
			keystroke "7" using command down
		end tell
	else if tabNum is equal to "8" then
		tell application "MenubarX" to activate
		delay 0.1
		tell application "System Events" to tell process "MenubarX"
			keystroke "8" using command down
		end tell
	else if tabNum is equal to "9" then
		tell application "MenubarX" to activate
		delay 0.1
			tell application "System Events" to tell process "MenubarX"
			keystroke "9" using command down
		end tell
	end if
end run
