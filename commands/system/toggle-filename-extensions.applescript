#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Toggle Filename Extensions
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 👓
# @raycast.packageName System

# Documentation:
# @raycast.description Show or hide all filename extensions (like .txt, .png)
# @raycast.author Senthil Prabhu
# @raycast.authorURL https://github.com/senthilprabhut

# Get the current setting value
try
	set CurSet to do shell script "defaults read NSGlobalDomain AppleShowAllExtensions"
on error
	set CurSet to "1"
end try

if CurSet is "1" then
	set NewSet to false
else
	set NewSet to true
end if

do shell script "defaults write NSGlobalDomain AppleShowAllExtensions -bool " & NewSet

# Restart Finder
do shell script "killall Finder"

# Show message
if CurSet is "1" then
	log "Show all filename extensions disabled"
else
	log "Show all filename extensions enabled"
end if
