#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Next Track
# @raycast.mode silent
# @raycast.packagename Tidal

# Optional parameters
# @raycast.icon images/tidal-logo.png

# Documentation:
# @raycast.author Charles Harries
# @raycast.authorURL https://github.com/charlesharries
# @raycast.description Skip to the next track in Tidal.

tell application "System Events"
  tell process "TIDAL"
    click menu item "Next" of menu "Playback" of menu bar 1
  end tell
end tell
return