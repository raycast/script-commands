#!/usr/bin/osascript

# Dependency: This script requires Slack to be installed: https://slack.com/

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Open Workspace by Name
# @raycast.mode silent

# Optional parameters:
# @raycast.icon images/slack-logo.png
# @raycast.packageName Slack
# @raycast.argument1 { "type": "text", "placeholder": "Name", "optional": true }

# Documentation:
# @raycast.author Jakub Lanski
# @raycast.authorURL https://github.com/jaklan

on run argv

	### Configuration ###

	# Delay time before triggering the click (used only when Slack needs to be initialized)
	set clickDelay to 5

	### End of configuration ###

	if application "Slack" is running then
		do shell script "open -a Slack"
	else
		do shell script "open -a Slack"
		delay clickDelay
	end if

	tell application "System Events" to tell process "Slack"
		if item 1 of argv = "" then
			click menu item 1 of menu 1 of menu item "Workspace" of menu 1 of menu bar item "File" of menu bar 1
		else
			set workspaces to name of menu items of menu 1 of menu item "Workspace" of menu 1 of menu bar item "File" of menu bar 1
			set workspaces to items 1 through -8 of workspaces

			repeat with workspace in workspaces
				if workspace contains item 1 of argv then
					click menu item workspace of menu 1 of menu item "Workspace" of menu 1 of menu bar item "File" of menu bar 1
					exit repeat
				end if
			end repeat
		end if
	end tell

end run
