#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Play
# @raycast.mode silent
# @raycast.packagename Tidal

# Optional parameters
# @raycast.icon images/tidal-logo.png

# Documentation:
# @raycast.author Charles Harries
# @raycast.authorURL https://github.com/charlesharries
# @raycast.description Play the current track in Tidal.

tell application "System Events"
  tell process "TIDAL"
    if name of menu item 0 of menu "Playback" of menu bar 1 is "Play" then
      click menu item "Play" of menu "Playback" of menu bar 1
    end if
  end tell
end tell
return