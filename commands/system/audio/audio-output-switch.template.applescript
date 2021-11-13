#!/usr/bin/osascript

# How to use this script?
# It's a template which needs further setup. Duplicate the file,
# remove `.template.` from the filename,
# Replace all instances of <Device Name> with the name of your desired audio output device

# @raycast.schemaVersion 1
# @raycast.title Switch Audio to <Device Name>
# @raycast.mode silent

# @raycast.packageName Audio
# @raycast.icon 🔊

# @raycast.author mmerle
# @raycast.authorURL https://github.com/mmerle
# @raycast.description Switch audio output to desired device.

set asrc to "<Device Name>"

tell application "System Preferences"

	reveal anchor "output" of pane id "com.apple.preference.sound"
	
	delay 1
	
	tell application "System Events"
		tell process "System Preferences"
			select (row 1 of table 1 of scroll area 1 of tab group 1 of window "Sound" whose value of text field 1 is asrc)
		end tell
	end tell
	
	quit
	
end tell

do shell script "echo Audio switched to <Device Name>"
