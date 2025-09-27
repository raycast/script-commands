#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Toggle Natural Scrolling (macOS 15+)
# @raycast.mode silent
# @raycast.packageName System

# Optional parameters:
# @raycast.icon 🖱
# @raycast.author Raphael-KR
# @raycast.authorURL https://github.com/Raphael-KR
# @raycast.description Toggle natural trackpad/mouse scrolling setting for macOS 15.6.1+

set macVersion to system version of (system info)

if macVersion is greater than or equal to "15" then
	try
		set isNaturalScrolling to (do shell script "defaults read .GlobalPreferences 'com.apple.swipescrolldirection' 2>/dev/null || echo '1'")
		
		if isNaturalScrolling is "1" then
			do shell script "defaults write .GlobalPreferences 'com.apple.swipescrolldirection' -bool NO"
			display notification "Natural Scrolling: OFF" with title "Trackpad Settings"
		else
			do shell script "defaults write .GlobalPreferences 'com.apple.swipescrolldirection' -bool YES"
			display notification "Natural Scrolling: ON" with title "Trackpad Settings"
		end if
		
		do shell script "/System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u"
		
	on error e
		display notification "Using GUI method as fallback" with title "Trackpad Settings"
		
		tell application "System Settings"
			activate
			set current pane to pane "com.apple.preference.trackpad"
		end tell
		
		delay 0.6
		
		tell application "System Events"
			tell process "System Settings"
				click radio button 2 of tab group 1 of window "Trackpad"
				click checkbox 1 of tab group 1 of window "Trackpad"
			end tell
		end tell
		
		tell application "System Settings" to quit
	end try
	
else
	display notification "For macOS 14 and earlier, use the original script" with title "Compatibility Note"
	
	tell application "System Settings"
		activate
		set current pane to pane "com.apple.preference.trackpad"
	end tell
	
	delay 0.6
	
	tell application "System Events"
		tell process "System Settings"
			click radio button 2 of tab group 1 of window "Trackpad"
			click checkbox 1 of tab group 1 of window "Trackpad"
		end tell
	end tell
	
	tell application "System Settings" to quit
end if
