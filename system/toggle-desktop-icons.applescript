#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Toggle Desktop Icons
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🖥

try
  set CurSet to do shell script "defaults read com.apple.finder CreateDesktop"
on error
  set CurSet to "1"
end try

if CurSet is "1" then
  set NewSet to false
else
  set NewSet to true
end if

do shell script "defaults write com.apple.finder CreateDesktop -bool " & NewSet

tell application "Finder"
  quit
  try
    activate
  end try
end tell