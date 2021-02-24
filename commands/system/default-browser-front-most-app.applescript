#!/usr/bin/osascript

# Dependency: requires defaultbrowser (https://github.com/kerma/defaultbrowser/)
# Install via Homebrew: `brew install defaultbrowser`

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Set Frontmost App as Default Browser
# @raycast.mode silent

# Optional parameters:
# @raycast.packageName Browsing
# @raycast.icon 🧭

# Documentation:
# @raycast.author Yohanes Bandung Bondowoso
# @raycast.authorURL https://github.com/ybbond
# @raycast.description Set Frontmost Web Browser as Default Browser.

tell application "System Events"
	tell (first process whose frontmost is true)
		set appName to displayed name
	end tell
end tell

set browserName to appName

if (appName contains "Brave Browser") then
	set browserName to "browser"
else if (appName is equal to "Safari") then
	set browserName to "safari"
else if (appName is equal to "Safari Technology Preview") then
	set browserName to "safaritechnologypreview"
else if (appName contains "Chrome") then
	set browserName to "chrome"
else if (appName is equal to "Chromium") then
	set browserName to "chromium"
else if (appName is equal to "Firefox") then
	set browserName to "firefox"
else if (appName is equal to "Firefox Developer Edition") then
	set browserName to "firefoxdeveloperedition"
end if


try
	set commandResult to do shell script "defaultbrowser" & space & browserName & space & "2>/dev/null "
	
	if (commandResult contains "The command exited with a non-zero status") then
		log "Shell command 'defaultbrowser' is required."
	else if (commandResult contains "is already set as the default HTTP handler" or commandResult is equal to "") then
		log appName & space & "already set as default browser"
	else if (commandResult contains "is not available as an HTTP handler") then
		log appName & space & "is not a web browser, or not handled yet :("
	end if
on error errStr
	set commandResult to errStr
	
	if (commandResult contains "The command exited with a non-zero status") then
		log "Shell command 'defaultbrowser' is required."
	else if (commandResult contains "is already set as the default HTTP handler" or commandResult is equal to "") then
		log appName & space & "already set as default browser"
	else if (commandResult contains "is not available as an HTTP handler") then
		log appName & space & "is not a web browser, or not handled yet :("
	end if
end try

try
	tell application "System Events"
		tell application process "CoreServicesUIAgent"
			tell window 1
				tell (first button whose name starts with "use")
					perform action "AXPress"
					log appName & space & "set as default browser"
				end tell
			end tell
		end tell
	end tell
end try
