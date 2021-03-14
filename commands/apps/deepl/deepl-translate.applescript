#!/usr/bin/osascript

# Dependency: This script requires DeepL to be installed: https://deepl.com/app

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title DeepL Translate
# @raycast.mode silent

# Optional parameters:
# @raycast.icon images/deepl.png
# @raycast.argument1 { "type": "text", "placeholder": "Text" }
# @raycast.packageName Apps

# Documentation:
# @raycast.description Translate text in DeepL for Mac
# @raycast.author Jono Hewitt
# @raycast.authorURL https://github.com/jonohewitt

on run translate
	
	if application "DeepL" is running then
		tell application "System Events"
			click UI element "DeepL" of list 1 of application process "Dock"
		end tell
		
	else
		activate application "DeepL"
		-- set time in seconds to wait for DeepL to load below
		-- this value may need to be increased on slower computers
		delay 1.2
	end if
	
	tell application "System Events"
		set value of text area 1 of group 5 of UI element 1 of scroll area 1 of group 1 of group 1 of window "DeepL" of application process "DeepL" to item 1 of translate
	end tell
	
end run