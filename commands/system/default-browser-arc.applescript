#!/usr/bin/osascript

# Dependency: requires defaultbrowser (https://github.com/kerma/defaultbrowser)
# Install via Homebrew: `brew install defaultbrowser`

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Default to Arc
# @raycast.mode silent
# @raycast.packageName Browser

# Optional parameters:
# @raycast.icon images/arc.png

# Documentation:
# @raycast.author Marcos Sánchez-Dehesa
# @raycast.authorURL https://github.com/dehesa
# @raycast.description Set Arc as the default browser.

# check to see what the current browser is
set currentDefaultBrowser to my getCurrentDefaultBrowser()

set repeatCount to 0

tell application "System Events"
	try
		my changeDefaultBrowser("browser")
		repeat until button 2 of window 1 of process "CoreServicesUIAgent" exists
			delay 0.01
			set repeatCount to repeatCount + 1
			if repeatCount = 15 then exit repeat
		end repeat
		try
			# if Chrome is the current default browser, the order of the buttons is reversed. Click button 1 to change the default browser to Arc.
			if currentDefaultBrowser contains "com.google.chrome" then
                click button 1 of window 1 of process "CoreServicesUIAgent"
            else    # otherwise click button 2 to change the default browser to Arc.
                click button 2 of window 1 of process "CoreServicesUIAgent"
            end if
			log "Arc is now your default browser"
		on error
			log "Arc is already your default browser"
		end try
	on error
		log "The \"defaultbrowser\" CLI tool is required: https://github.com/kerma/defaultbrowser 🔥"
	end try
end tell

to getCurrentDefaultBrowser()
    set filePath to "~/Library/Preferences/com.apple.LaunchServices/com.apple.launchservices.secure.plist"

    set output to do shell script "plutil -p " & filePath & " | awk '/LSHandlerRoleAll/{a=$3}/LSHandlerURLScheme/{if($3==\"\\\"https\\\"\") print a}'"
    return output
end getCurrentDefaultBrowser

to changeDefaultBrowser(thebrowser)
	do shell script "
		if ! command -v defaultbrowser &> /dev/null; then
  		exit 1
		fi
		defaultbrowser " & thebrowser & "
		exit 0
	"
end changeDefaultBrowser