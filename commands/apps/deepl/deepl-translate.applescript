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


# If your system uses different shortcuts to 'cmd + A' for select-all, or 'cmd + V' for paste,
# you can adjust the keystroke letters towards the end of the script

# Note that using this script will replace the existing clipboard contents

on run translate
	set the clipboard to item 1 of translate

	if application "DeepL" is not running then
		activate application "DeepL"
		-- set time in seconds to wait for DeepL to open below
		-- may need to be increased on slower computers
		delay 1.2
	end if

	tell application "System Events"
		click UI element "DeepL" of list 1 of application process "Dock"
		select text area 1 of group 5 of UI element 1 of scroll area 1 of group 1 of group 1 of window "DeepL" of application process "DeepL"
		-- assign cmd letters for 'select-all' and 'paste' below
		keystroke "a" using {command down}
		keystroke "v" using {command down}
	end tell
end run