#!/usr/bin/osascript

# Dependency: This script requires Slack to be installed: https://slack.com/

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Open Workspace by Index
# @raycast.mode silent

# Optional parameters:
# @raycast.icon images/slack-logo.png
# @raycast.packageName Slack
# @raycast.argument1 { "type": "text", "placeholder": "Index", "optional": true }

# Documentation:
# @raycast.author Jakub Lanski
# @raycast.authorURL https://github.com/jaklan

on run argv

	### Configuration ###

	# Delay time before triggering the keystroke (used only when Slack needs to be initialized)
	set keystrokeDelay to 5

	### End of configuration ###

	if item 1 of argv = "" then
		set serviceIndex to 1
	else
		set serviceIndex to item 1 of argv
	end if

	if application "Slack" is running then
		do shell script "open -a Slack"
	else
		do shell script "open -a Slack"
		delay keystrokeDelay
	end if

	tell application "System Events" to keystroke serviceIndex using command down

end run
