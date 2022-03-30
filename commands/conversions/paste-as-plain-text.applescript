#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Paste and Match Style
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 📋
# @raycast.packageName Conversions
# @raycast.description A script to click the "Paste and Match Style" menu item, even if it's disabled

# Documentation:
# @raycast.author Michael Bianco
# @raycast.authorURL https://github.com/iloveitaly

tell application "System Events"
  tell process 1 where frontmost is true
    click menu item "Paste and Match Style" of menu "Edit" of menu bar 1
  end tell
end tell
