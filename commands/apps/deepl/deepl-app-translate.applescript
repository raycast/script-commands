#!/usr/bin/osascript

# Dependency: This script requires DeepL to be installed: https://deepl.com/app
# Tested with DeepL for Mac Version 3.1.133440

# Once installed, DeepL will run in the background even if you quit the app from the dock
# This script will work as long as the DeepL icon is visible in the menu bar in the top right
# Configuration options are available in the script below

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title DeepL App Translate
# @raycast.mode silent

# Optional parameters:
# @raycast.icon images/deepl.png
# @raycast.argument1 { "type": "text", "placeholder": "text", "optional": true }
# @raycast.packageName Apps

# Documentation:
# @raycast.description Translate text in DeepL for Mac. Features options to input from the clipboard as well as automatically copy translation results.
# @raycast.author Jono Hewitt
# @raycast.authorURL https://github.com/jonohewitt

on run translate
	
	### Configuration: ###
    
	-- Choose whether to use the clipboard as the input if no input argument is entered in Raycast:
    set useClipboardAsInput to false

	-- Choose whether the translation result should be automatically copied to the clipboard:
	set copyResultToClipboard to false
	
	### End of configuration ###

    do shell script "open -a DeepL"
	
	set inputText to ""
	
	if item 1 of translate is "" then
		if useClipboardAsInput is true
			set inputText to the clipboard
		end if
	else
		set inputText to item 1 of translate
	end if
	
	tell application "System Events"
		set value of text area 1 of group 3 of group 1 of group 1 of UI Element 1 of scroll area 1 of group 1 of group 1 of window "DeepL" of process "DeepL" to inputText
	end tell
	
	if copyResultToClipboard is true then
		set translation to ""
		set timeoutSeconds to 10.0
		set endDate to (current date) + timeoutSeconds
		
		tell application "System Events"
			repeat until translation is not ""

				if exists of text area 1 of group 6 of group 3 of group 1 of UI Element 1 of scroll area 1 of group 1 of group 1 of window "DeepL" of process "DeepL"
					set translation to value of text area 1 of group 6 of group 3 of group 1 of UI Element 1 of scroll area 1 of group 1 of group 1 of window "DeepL" of process "DeepL"
				end if

				if ((current date) > endDate) then
					exit repeat
				end if
				delay 0.2
			end repeat
		end tell
		
		if translation is not ""
			set the clipboard to translation
		end if
	end if
	
end run