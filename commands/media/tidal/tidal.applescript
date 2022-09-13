#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Toggle Play/Pause
# @raycast.mode silent
# @raycast.packagename Tidal

# Optional parameters
# @raycast.icon images/tidal-logo.png

# Documentation:
# @raycast.author Cebrail AKTAS
# @raycast.authorURL https://github.com/AktasC
# @raycast.description Play/Pause Tidal

tell application "System Events"
  tell process "TIDAL"
    click first menu item of menu "Playback" of menu bar 1
    if name of first menu item of menu "Playback" of menu bar 1 is "Play" then
      log "▶️"
    else
      log "⏸"
    end if
  end tell
end tell
