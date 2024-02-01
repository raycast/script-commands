#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Toggle Mute Notifcation Sounds
# @raycast.mode silent
# @raycast.packageName System

# Optional parameters:
# @raycast.icon 🔔

# Documentation:
# @raycast.author Annie Ma
# @raycast.authorURL http://www.anniema.co/
# @raycast.description Toggles notification sounds.

set volumeSettings to get volume settings
set alertVolume to alert volume of volumeSettings

if alertVolume > 0 then
    set volume alert volume 0
    display notification "" with title "Muted notification sounds"
else
    set volume alert volume 100
    display notification "" with title "Unmuted notification sounds"
end if

