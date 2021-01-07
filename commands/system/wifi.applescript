#!/usr/bin/osascript

# @raycast.title Wi-Fi
# @raycast.author Vincent Dörig
# @raycast.authorURL https://github.com/vincentdoerig
# @raycast.description Turn your Wi-Fi on or off.

# @raycast.icon images/wifi-dark.png
# @raycast.iconDark images/wifi.png
# @raycast.mode silent
# @raycast.packageName System
# @raycast.schemaVersion 1
# @raycast.argument1 { "type": "text", "placeholder": "on/off" }

on run argv
  if item 1 of argv is "off" then
    do shell script "networksetup -setairportpower en1 off"
    do shell script "echo Wi-Fi turned off"
  else if item 1 of argv is "on" then
    do shell script "networksetup -setairportpower en1 on"
    do shell script "echo Wi-Fi turned on"
  else
    do shell script "echo Invalid param provided"
  end if
end run
