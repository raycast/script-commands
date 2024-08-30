#!/usr/bin/osascript

# @raycast.schemaVersion 1
# @raycast.author Chris Bailey
# @raycast.authorURL https://raycast.com/that70schris
# @raycast.description Easily hide your foremost application
# @raycast.packageName Navigation
# @raycast.title Hide Current Application
# @raycast.mode silent
# @raycast.icon 🫥

tell application "System Events"
	tell (first process whose frontmost is true)
		set _name to displayed name
	end tell

  set visible of application process _name to false
end tell
