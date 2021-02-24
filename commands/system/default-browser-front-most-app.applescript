#!/usr/bin/osascript

# Dependency: requires defaultbrowser (https://github.com/kerma/defaultbrowser/)
# Install via Homebrew: `brew install defaultbrowser`

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Set Default Browser to Front Most
# @raycast.mode silent

# Optional parameters:
# @raycast.packageName Browsing
# @raycast.icon 🧭

# Documentation:
# @raycast.author Yohanes Bandung Bondowoso
# @raycast.authorURL https://github.com/ybbond
# @raycast.description Set Front Most Web Browser as Default Browser.

tell application "System Events"
	tell (first process whose frontmost is true)
		set appName to displayed name
	end tell
end tell

set browserName to ""

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
	if (browserName is equal to "") then
		log appName & space & "is not handled yet :("
	else
		do shell script ("/usr/local/bin/defaultbrowser" & space & browserName)
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
		on error errorMessage number errorNumber
			if errorNumber is equal to -1719 then
				log appName & space & "already set as default browser"
			else
				log "Error on setting" & space & appName & space & "as default browser. Try again or consult online"
			end if
		end try
	end if
end try
