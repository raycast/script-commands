#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Toggle Hidden Files
# @raycast.mode silent
# @raycast.packageName System

# Optional parameters:
# @raycast.icon 👓
# @raycast.author Thiago Holanda
# @raycast.authorURL https://twitter.com/tholanda
# @raycast.description Show and hide hidden files/folders which starts with "." (dot), i.e: .bash_rc, .ssh

try
	set VisibleFiles to do shell script "defaults read com.apple.finder AppleShowAllFiles"
on error
	set VisibleFiles to "1"
end try

if VisibleFiles is "1" then
	set NewSet to false
else
	set NewSet to true
end if

do shell script "defaults write com.apple.finder AppleShowAllFiles -bool " & NewSet

do shell script "killall Finder"