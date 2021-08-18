#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Search Apple Music
# @raycast.mode compact

# Optional parameters:
# @raycast.icon images/apple-music-logo.png
# @raycast.argument1 { "type": "text", "placeholder": "searching..." }
# @raycast.packageName Apple Music Search

# Documentation:
# @raycast.description Search using the native UI
# @raycast.author StevenRCE0
# @raycast.authorURL https://github.com/StevenRCE0

on run argv
	do shell script "open /System/Applications/Music.app"
	
	# Argh, the window title varies... Add your language if it's not here...
	set musicWindow to {"Music", "ミュージック", "音乐", "音樂"}
	set notShowing to true
	
	# Thanks StactOverflow user mklement0 for the code below detecting window name ;-)
	# Tell the *process* to count its windows and return its front window's name.
	tell application "System Events"
		# Get the frontmost app's *process* object.
		set frontAppProcess to first application process whose frontmost is true
	end tell
	tell frontAppProcess
		if (count of windows) > 0 then
			set window_name to name of front window
			if window_name is in musicWindow then
				set notShowing to false
			end if
		end if
	end tell
	if notShowing is true then
		tell application "System Events" to keystroke "0" using command down
	end if
	
	log "Trying to search " & {item 1 of argv}
	set savedClipboard to the clipboard
	set the clipboard to ({item 1 of argv} as text)
	delay 0.1
	tell application "System Events"
		keystroke "f" using command down
		keystroke "a" using command down
		key code 51
		keystroke "v" using command down
		key code 36
	end tell
	delay 0.1
	set the clipboard to savedClipboard
end run