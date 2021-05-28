#!/usr/bin/osascript

# Install HazeOver via Mac App Store: https://apps.apple.com/gb/app/hazeover-distraction-dimmer/id430798174

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Toggle Dimming
# @raycast.mode silent
# @raycast.packageName HazeOver

# Optional parameters:
# @raycast.icon images/hazeover.png

# Documentation:
# @raycast.author Thomas Paul Mann
# @raycast.authorURL https://github.com/thomaspaulmann
# @raycast.description Toggle dimming of all background windows.

tell application "HazeOver"
  set enabled to not enabled

  if enabled then
    log "Enabled dimming"
  else
    log "Disabled dimming"
  end if
end tell
