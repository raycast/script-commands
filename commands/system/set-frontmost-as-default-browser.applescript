#!/usr/bin/osascript

# Dependency: requires defaultbrowser (https://github.com/kerma/defaultbrowser/)
# Install via Homebrew: `brew install defaultbrowser`

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Set Default Browser to Front Most
# @raycast.mode silent

# Optional parameters:
# @raycast.packageName Browsing

# Documentation:
# @raycast.author Yohanes Bandung Bondowoso
# @raycast.authorURL https://github.com/ybbond
# @raycast.description Set Safari, Brave, Chrome or Firefox as default browser.

tell application "System Events"
	tell (first process whose frontmost is true)
		set appName to displayed name
	end tell
end tell

if (appName contains "Brave Browser") then
	do shell script ("/usr/local/bin/defaultbrowser browser")
	try
		tell application "System Events"
			tell application process "CoreServicesUIAgent"
				tell window 1
					tell (first button whose name starts with "use")
						perform action "AXPress"
						display notification appName & space & "set as default browser"
					end tell
				end tell
			end tell
		end tell
	end try
else if (appName contains "Safari") then
	do shell script ("/usr/local/bin/defaultbrowser safari")
	try
		tell application "System Events"
			tell application process "CoreServicesUIAgent"
				tell window 1
					tell (first button whose name starts with "use")
						perform action "AXPress"
						display notification appName & space & "set as default browser"
					end tell
				end tell
			end tell
		end tell
	end try
else if (appName contains "Chrome") then
	do shell script ("/usr/local/bin/defaultbrowser chrome")
	try
		tell application "System Events"
			tell application process "CoreServicesUIAgent"
				tell window 1
					tell (first button whose name starts with "use")
						perform action "AXPress"
						display notification appName & space & "set as default browser"
					end tell
				end tell
			end tell
		end tell
	end try
else if (appName contains "Firefox") then
	do shell script ("/usr/local/bin/defaultbrowser firefox")
	try
		tell application "System Events"
			tell application process "CoreServicesUIAgent"
				tell window 1
					tell (first button whose name starts with "use")
						perform action "AXPress"
						display notification appName & space & "set as default browser"
					end tell
				end tell
			end tell
		end tell
	end try
end if
