#!/usr/bin/osascript

# Dependency: This script requires Slack to be installed: https://slack.com/

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Jump to...
# @raycast.mode silent

# Optional parameters:
# @raycast.icon images/slack-logo.png
# @raycast.packageName Slack
# @raycast.argument1 { "type": "text", "placeholder": "Channel / DM / File / Misc" }

# Documentation:
# @raycast.author Jakub Lanski
# @raycast.authorURL https://github.com/jaklan

on run argv

	### Configuration ###

	# Delay time before triggering the keystroke for the Quick Switcher
	# (used only when Slack needs to be initialized)
	set keystrokeDelay to 5
	# Delay time before entering the input
	set inputDelay to 0.5
	# Delay time before triggering the "enter" keystroke
	set enterDelay to 0.5

	### End of configuration ###

	if application "Slack" is running then
		do shell script "open -a Slack"
	else
		do shell script "open -a Slack"
		delay keystrokeDelay
	end if

	tell application "System Events"
		keystroke "k" using command down
		delay inputDelay
		keystroke item 1 of argv
		delay enterDelay
		key code 36
	end tell

end run
