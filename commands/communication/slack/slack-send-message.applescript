#!/usr/bin/osascript

# Required parameters:
# @raycast.author Faris Aziz
# @raycast.authorURL https://github.com/farisaziz12
# @raycast.schemaVersion 1
# @raycast.title Send Message in Channel
# @raycast.mode silent
# @raycast.packageName Slack
# @raycast.description This script posts a message text to a slack channel and sets active status (defaults to random good morning message in #general)
# @raycast.needsConfirmation true
# @raycast.argument1 { "type": "text", "placeholder": "Channel (default: #general)", "optional": true, }
# @raycast.argument2 { "type": "text", "placeholder": "Message (default: good morning)", "optional": true, }
# @raycast.argument3 { "type": "text", "placeholder": "Set Active? y/n", "optional": true, }


# Optional parameters:
# @raycast.icon images/slack-logo.png


on openChannel(channel)
	tell application "Slack"
		activate
		tell application "System Events"
			keystroke "k" using {command down}
			delay 0.5
			keystroke channel
			delay 0.5
			key code 36
			delay 0.5
		end tell
	end tell
end openChannel

on sendMessage(msg)
	tell application "Slack"
		activate
		tell application "System Events"
			keystroke msg
			delay 0.5
			key code 36
		end tell
	end tell
end sendMessage

on slashCommand(cmd)
	tell application "Slack"
		activate
		tell application "System Events"
			key code 44
			delay 0.5
			keystroke cmd
			delay 0.5
			key code 36
		end tell
	end tell
end slashCommand

on pressReturn()
	tell application "Slack"
		activate
		tell application "System Events"
			delay 1
			key code 36
		end tell
	end tell
end pressReturn

on run argv
    set channel to item 1 of argv
    set message to item 2 of argv
    set setActive to item 3 of argv
    set today to do shell script "date +%A"
    set todayText to "Happy " & today & "!"
    set goodMorningTexts to {"Good Morning all!", "Good Morning Everyone!", todayText }
    set randomItemNum to random number from 1 to count of goodMorningTexts
    set randomGoodMorningText to item randomItemNum of goodMorningTexts as string

-- if no channel argument set #general as default
    if channel = "" then
        set channelToSendTo to "#general"
    else
        set channelToSendTo to channel
    end if

-- if no message argument set random good morning message as default
    if message = "" then
        set messageToSend to randomGoodMorningText
    else
        set messageToSend to message
    end if

    openChannel(channelToSendTo)
    -- setting to active will not work if already active
    if setActive = "y" or setActive = "Y" then
        sendMessage(messageToSend)
        slashCommand("Set yourself as active")
        pressReturn()
        log messageToSend & " sent To " & channelToSendTo &" and status set to active!"
    else if setActive = "n" or setActive = "N" or setActive = "" -- default is no
        sendMessage(messageToSend)
        log messageToSend & " sent To " & channelToSendTo &"!"
    else
        log "Invalid argument for set active. Specify setting active using 'y' or 'n'"
    end if
end run
