#!/usr/bin/osascript

# Assumption: Evernote running (launching and waiting not great UX)
#
# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Create Evernote
# @raycast.mode silent
#
# Optional parameters:
# @raycast.icon ./images/evernote.png
# @raycast.packageName Evernote
#
# Documentation:
# @raycast.description Creates a new Evernote.
# @raycast.author Aaron Miller
# @raycast.authorURL https://github.com/aaronhmiller

tell application "System Events"
  tell process "Evernote"
    set frontmost to true
    click menu item "New Note" of menu "File" of menu bar 1
  end tell
end tell
do shell script "echo New Evernote created"
