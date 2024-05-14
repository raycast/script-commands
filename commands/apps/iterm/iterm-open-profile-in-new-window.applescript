#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Open iterm2 profile
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🤖
# @raycast.argument1 { "type": "text", "placeholder": "Placeholder" }
# @raycast.packageName Open_iterm2_profile

# Documentation:
# @raycast.author sunrisewestern
# @raycast.authorURL https://github.com/sunrisewestern

on is_running(appName)
	tell application "System Events" to (name of processes) contains appName
end is_running

on run {argv}
	set iTermRunning to is_running("iTerm2")
	tell application "iTerm"
		activate
		if not (iTermRunning) then
			delay 0.5
			close the current window
		end if
		create window with profile argv
	end tell
end run
