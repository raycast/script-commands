#!/usr/bin/osascript

# Assumption: Evernote running (launching and waiting not great UX)
#
# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Create Evernote Paste Clipboard
# @raycast.mode silent
#
# Optional parameters:
# @raycast.icon ./images/evernote.png
# @raycast.packageName Evernote
#
# Documentation:
# @raycast.description Creates a new Evernote, pastes in the contents of the clipboard, and positions the cursor in the title area.
# @raycast.author Aaron Miller
# @raycast.authorURL https://github.com/aaronhmiller

tell application "System Events"
  tell process "Evernote"
    set frontmost to true
    click menu item "New Note" of menu "File" of menu bar 1
    delay 2 --needed b/c Electron apps slow
    click menu item "Paste" of menu "Edit" of menu bar 1
    delay 1
    tell application "System Events" to key code 48 using shift down -- shift-tab (move cursor to Title area)
  end tell
end tell
do shell script "echo New Evernote created"
