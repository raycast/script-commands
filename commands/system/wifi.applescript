#!/usr/bin/osascript

# @raycast.title Toggle Wi-Fi
# @raycast.author Vincent Dörig
# @raycast.authorURL https://github.com/vincentdoerig
# @raycast.description Toggle your Wi-Fi connection.

# @raycast.icon images/wifi-dark.png
# @raycast.iconDark images/wifi.png
# @raycast.mode silent
# @raycast.packageName System
# @raycast.schemaVersion 1

# Wi-Fi interface, should normally be either `en0` or `en1`
set Interface to "en0"
set NetworkStatus to (do shell script "networksetup -getairportnetwork " & Interface)
if (NetworkStatus contains "off") then
  # turn Wi-Fi on
  do shell script "networksetup -setairportpower Interface on"
  do shell script "echo Wi-Fi turned on"
else
  # turn Wi-Fi off
  do shell script "networksetup -setairportpower Interface off"
  do shell script "echo Wi-Fi turned off"
end if
