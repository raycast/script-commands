#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Previous Track
# @raycast.mode silent
# @raycast.packagename Tidal

# Optional parameters
# @raycast.icon images/tidal-logo.png

# Documentation:
# @raycast.author Charles Harries
# @raycast.authorURL https://github.com/charlesharries
# @raycast.description Skip back to the previous track in Tidal.

tell application "System Events"
  tell process "TIDAL"
    click menu item "Previous" of menu "Playback" of menu bar 1
  end tell
end tell
return