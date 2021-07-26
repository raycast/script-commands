#!/usr/bin/osascript

# Dependency: This script requires Messenger to be installed: https://www.messenger.com/desktop

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Open Conversation
# @raycast.mode silent

# Optional parameters:
# @raycast.icon images/messenger.png
# @raycast.packageName Messenger
# @raycast.argument1 { "type": "text", "placeholder": "Name" }

# Documentation:
# @raycast.author Jakub Lanski
# @raycast.authorURL https://github.com/jaklan

on run argv

	### Configuration ###

	# Delay time before triggering the keystroke for the Search
	# (used only when Messenger needs to be initialized)
	set keystrokeDelay to 2.5
	# Delay time before triggering the "⌘1" keystroke
	set conversationKeystrokeDelay to 1

	### End of configuration ###

	if application "Messenger" is running then
		do shell script "open -a Messenger"
	else
		do shell script "open -a Messenger"
		delay keystrokeDelay
	end if

	tell application "System Events" to tell process "Messenger"
		keystroke "k" using command down
		keystroke item 1 of argv
		delay conversationKeystrokeDelay
		keystroke "1" using command down
	end tell

end run
