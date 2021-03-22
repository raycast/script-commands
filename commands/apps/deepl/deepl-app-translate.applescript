#!/usr/bin/osascript

# Dependency: This script requires DeepL to be installed: https://deepl.com/app

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title DeepL App Translate
# @raycast.mode silent

# Optional parameters:
# @raycast.icon images/deepl.png
# @raycast.argument1 { "type": "text", "placeholder": "text", "optional": true }
# @raycast.packageName Apps

# Documentation:
# @raycast.description Translate text in DeepL for Mac. Copies from the clipboard if no text argument is given.
# @raycast.author Jono Hewitt
# @raycast.authorURL https://github.com/jonohewitt

on run translate
	
	### Configuration: ###
	
	-- choose whether the translation result should be automatically copied to the clipboard:
	set copyResultToClipboard to false
	
	-- set time in seconds to wait for DeepL to load below. It may need to be increased on slower computers
	set delayTime to 1.2
	
	###
	
	if application "DeepL" is running then
		tell application "System Events"
			click UI element "DeepL" of list 1 of application process "Dock"
		end tell
	else
		activate application "DeepL"
		delay delayTime
	end if
	
	set inputText to ""
	
	if item 1 of translate is equal to "" then
		set inputText to the clipboard
	else
		set inputText to item 1 of translate
	end if
	
	tell application "System Events"
		set value of text area 1 of group 5 of UI element 1 of scroll area 1 of group 1 of group 1 of window "DeepL" of application process "DeepL" to inputText
	end tell
	
	if copyResultToClipboard is equal to true then
		set translation to ""
		
		tell application "System Events"
			repeat until translation is not equal to ""
				set translation to value of text area 1 of group 12 of UI element 1 of scroll area 1 of group 1 of group 1 of window "DeepL" of application process "DeepL"
			end repeat
		end tell
		
		set the clipboard to translation
	end if
	
end run