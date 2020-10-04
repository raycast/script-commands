#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Toggle Hidden Files
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 👓
# @raycast.author Thiago Holanda
# @raycast.authorURL https://twitter.com/tholanda
# @raycast.description Script Command to show and hide files and folders starting with "." (dot) which on Unix, means that is a hidden file/folder

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