#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Toggle Natural Scrolling
# @raycast.mode silent
# @raycast.packageName System

# Optional parameters:
# @raycast.icon 🖱
# @raycast.author Wiley Marques
# @raycast.authorURL https://twitter.com/wileymarques
# @raycast.description Script Command to change natural trackpad/mouse scrolling setting. Reverting the setting value each time.

set macVersion to system version of (system info)

if macVersion is greater than or equal to "14" then
	set isNaturalScrolling to (do shell script "defaults -currentHost read NSGlobalDomain com.apple.swipescrolldirection")
	
	if isNaturalScrolling is "1" then
		do shell script "defaults -currentHost write NSGlobalDomain com.apple.swipescrolldirection -bool NO"
	else
		do shell script "defaults -currentHost write NSGlobalDomain com.apple.swipescrolldirection -bool YES"
	end if
	
	do shell script "/System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u"
else
	tell application "System Settings"
		activate
		set current pane to pane "com.apple.preference.trackpad"
	end tell
	
	delay 0.6
	
	tell application "System Events"
		tell process "System Preferences"
			click radio button 2 of tab group 1 of window "Trackpad"
			click checkbox 1 of tab group 1 of window "Trackpad"
		end tell
	end tell
	
	tell application "System Settings" to quit
end if
