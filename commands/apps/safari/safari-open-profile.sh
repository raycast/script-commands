#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Safari Profile
# @raycast.mode silent

# Optional parameters:
# @raycast.icon images/safari.png
# @raycast.packageName Safari
# @raycast.argument1 { "type": "text", "placeholder": "profile", "optional": true }

# Documentation:
# @raycast.description Open Safari with a given profile (default is Personal).
# @raycast.author Alex Gerdes
# @raycast.authorURL http://www.botkes.nl

osascript <<EOD
  tell application "Safari" to activate

  tell application "System Events"
    tell process "Safari"
      click menu item "New ${1:-Personal} Window" of menu 1 of menu item "New Window" of menu "File" of menu bar 1
    end tell
  end tell
EOD
