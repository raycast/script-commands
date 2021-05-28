#!/usr/bin/osascript

# Install HazeOver via Mac App Store: https://apps.apple.com/gb/app/hazeover-distraction-dimmer/id430798174

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Set Intensity
# @raycast.mode silent
# @raycast.packageName HazeOver
# @raycast.argument1 { "type": "text", "placeholder": "Intensity (0-100)" }

# Optional parameters:
# @raycast.icon images/hazeover.png

# Documentation:
# @raycast.author Thomas Paul Mann
# @raycast.authorURL https://github.com/thomaspaulmann
# @raycast.description Set dimming intensity of background windows.

on run argv 
  tell application "HazeOver"
    set newIntensity to item 1 of argv as integer
    
    if newIntensity < 0 then
      newIntensity = 0
    else if newIntensity > 100 then
      newIntensity = 100
    end if
    
    set intensity to newIntensity

    log "Set intensity to " & newIntensity & "%"
  end tell
end run