#!/usr/bin/osascript

# Install Fantastical via the Mac App Store: https://apps.apple.com/us/app/fantastical-calendar-tasks/id975937182

# @raycast.title Create Task
# @raycast.author Vardan Sawhney
# @raycast.authorURL https://github.com/commai
# @raycast.description Speed up setting reminders for Fantastical by invoking this script.
# @raycast.schemaVersion 1

# @raycast.icon ./images/fantastical.png
# @raycast.mode silent
# @raycast.packageName Fantastical
# @raycast.argument1 { "type": "text", "placeholder": "Task to complete" }


on run argv
	tell application "Fantastical"
		parse sentence "todo today " & (item 1 of argv)
	end tell
end run
