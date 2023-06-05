#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title chatgpt
# @raycast.mode silent

# Optional parameters:
# @raycast.icon images/chatgpt.png
# @raycast.packageName Chatgpt Util

# Documentation:
# @raycast.description Open chatgpt in safari
# @raycast.author gintonyc
# @raycast.authorURL https://raycast.com/gintonyc


tell application "Safari"
	set targetURLPrefix to "https://chat.openai.com"
	set foundTab to false
	
	repeat with aWindow in windows
		repeat with aTab in (tabs of aWindow)
			set tabURL to URL of aTab
			if tabURL starts with targetURLPrefix then
				set foundTab to true
				set current tab of aWindow to aTab
				exit repeat
			end if
		end repeat
		if foundTab then exit repeat
	end repeat
	
	if not foundTab then
		make new document with properties {URL:targetURLPrefix}
	end if
	activate
end tell