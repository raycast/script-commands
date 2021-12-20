#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Search
# @raycast.mode silent

# Optional parameters:
# @raycast.icon images/apple-music-logo.png
# @raycast.argument1 { "type": "text", "placeholder": "Artist or Music" }
# @raycast.packageName Apple Music

# Documentation:
# @raycast.description Search using the native UI
# @raycast.author StevenRCE0
# @raycast.authorURL https://github.com/StevenRCE0

on run argv
	set savedClipboard to the clipboard
	set the clipboard to ({item 1 of argv} as text)
	try
		do shell script "open /System/Applications/Music.app"
		tell application "Music" to activate
		set using to "Music"
	on error
		try
		do shell script "open /Applications/iTunes.app"
			tell application "iTunes" to activate
			set using to "iTunes"
		end try
	end try
	
	# Argh, the window title varies... Add your language if it's not here...
	set musicWindow to {"Music", "ミュージック", "音乐", "音樂"}
	set notShowing to true
	set toLaunch to true

	repeat while toLaunch
		if using is "Music" and application "Music" is running then set toLaunch to false
		if using is "iTunes" and application "iTunes" is running then set toLaunch to false
		delay 0.5
	end repeat
	
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
	
	delay 0.1
	tell application "System Events"
		keystroke "f" using command down
		keystroke "a" using command down
		keystroke "v" using command down
		key code 36
	end tell
	delay 5
	set the clipboard to savedClipboard
	log "Done"
end run