#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Rename Profile
# @raycast.description Rename your profile in Zoom Meeting App (Mac Only) and cliclick.
# @raycast.mode silent
# @raycast.packageName Zoom
# @raycast.argument1 { "type": "text", "placeholder": "AFK for?" }

# Optional parameters:
# @raycast.icon images/zoom-logo.png

# Documentation:
# @raycast.author Leo Voon
# @raycast.authorURL https://github.com/leovoon

on run argv
	
	tell application "System Events"
		tell application process "zoom.us"
			set frontmost to true
			set windowIsOpen to false
			set participantsWindow to missing value
			set renameWindow to missing value
			
			repeat with w in windows
				if name of w contains "Participants" then
					set windowIsOpen to true
					set participantsWindow to w
					exit repeat
				end if
			end repeat
			
			delay 0.5
			set foundRename to false
			-- Hover on name
			do shell script "/opt/homebrew/bin/cliclick m:" & 1183 & "," & 124
			delay 0.5

			-- Hover on More button
			do shell script "/opt/homebrew/bin/cliclick m:" & 1400 & "," & 124
			delay 0.5

			-- Click More button
			do shell script "/opt/homebrew/bin/cliclick c:" & 1400 & "," & 124
			delay 0.5	

			-- Click Arrow Down
			do shell script "/opt/homebrew/bin/cliclick kp:arrow-down kp:arrow-down kp:return"
			delay 0.5

			-- Target Rename and Hit Return Key
			do shell script "/opt/homebrew/bin/cliclick kp:return"
			
			-- Edit Input, modify here for your needs
			delay 0.5
			set newName to "YOUR NAME -" & ( item 1 of argv )
			delay 0.5
			do shell script "/opt/homebrew/bin/cliclick c:" & 888 & "," & 430
			delay 0.5
			key code 51 using {command down}
			keystroke newName
			delay 0.5
			do shell script "/opt/homebrew/bin/cliclick c:" & 880 & "," & 517
			
			
		end tell
	end tell
end run