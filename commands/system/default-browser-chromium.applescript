#!/usr/bin/osascript

# Dependency: requires defaultbrowser (https://github.com/kerma/defaultbrowser)
# Install via Homebrew: `brew install defaultbrowser`

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Default to Chromium
# @raycast.mode silent
# @raycast.packageName Browser

# Optional parameters:
# @raycast.icon images/chrome-icon.png

# Documentation:
# @raycast.author Marcos Sánchez-Dehesa
# @raycast.authorURL https://github.com/dehesa
# @raycast.description Set Chromium as the default browser.

set repeatCount to 0

tell application "System Events"
	try
		my changeDefaultBrowser("chromium")
		repeat until button 2 of window 1 of process "CoreServicesUIAgent" exists
			delay 0.01
			set repeatCount to repeatCount + 1
			if repeatCount = 15 then exit repeat
		end repeat
		try
			click button 2 of window 1 of process "CoreServicesUIAgent"
			log "Chromium is now your default browser"
		on error
			log "Chromium is already your default browser"
		end try
	on error
		log "The \"defaultbrowser\" CLI tool is required: https://github.com/kerma/defaultbrowser 🔥"
	end try
end tell

to changeDefaultBrowser(thebrowser)
	do shell script "
		if ! command -v defaultbrowser &> /dev/null; then
  		exit 1
		fi
		defaultbrowser " & thebrowser & "
		exit 0
	"
end changeDefaultBrowser