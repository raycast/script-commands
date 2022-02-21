#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Pause
# @raycast.mode silent
# @raycast.packagename Tidal

# Optional parameters
# @raycast.icon images/tidal-logo.png

# Documentation:
# @raycast.author Charles Harries
# @raycast.authorURL https://github.com/charlesharries
# @raycast.description Pause the current track in Tidal.

tell application "System Events"
  tell process "TIDAL"
    if name of menu item 0 of menu "Playback" of menu bar 1 is "Pause" then
      click menu item "Pause" of menu "Playback" of menu bar 1
    end if
  end tell
end tell
return