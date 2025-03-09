#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Sleep Timer
# @raycast.mode silent
# @raycast.description Put your Mac to sleep (in X minutes).
# @raycast.packageName System

# Optional parameters:
# @raycast.icon 😴
# @raycast.argument1 { "optional": true, "type": "text", "placeholder": "(in) minutes" }

# Documentation:
# @raycast.author AndriiBarabash
# @raycast.authorURL https://github.com/AndriiBarabash

on run argv
  delay (item 1 of argv) * 60
  tell application "Finder" to sleep
end run

