#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Custom Window Size
# @raycast.mode silent
# @raycast.packageName System

# Optional parameters:
# @raycast.icon images/custom-window-size.png

# Documentation:
# @raycast.author Astrit
# @raycast.authorURL https://github.com/astrit
# @raycast.description Resize and center the frontmost window to any custom size.

# @raycast.argument1 { "type": "text", "placeholder": "Width" }
# @raycast.argument2 { "type": "text", "placeholder": "Height" }

on run argv

	tell application "System Events"
		set frontApp to name of first application process whose frontmost is true
	end tell

	tell application "Finder"
    get bounds of window of desktop
	end tell

	tell application "Finder"
    set desktopBounds to bounds of window of desktop
    set screenWidth to item 3 of desktopBounds
    set screenHeight to item 4 of desktopBounds
	end tell

	set theApp to frontApp
	set appWidth to "" & ( item 1 of argv )
	set appHeight to "" & ( item 2 of argv )

	tell application frontApp to activate
	tell application "System Events" to tell application process frontApp
		try
			set size of window 1 to {appWidth, appHeight}
			set position of window 1 to {(screenWidth - appWidth) / 2.0, (screenHeight - appHeight) / 2.0}
		on error errmess
			log errmess
			-- no window open
		end try
	end tell
end run
