#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Translate in Bob
# @raycast.mode silent
# @raycast.packageName Navigation

# Optional parameters:
# @raycast.icon images/bob.png
# @raycast.argument1 { "type": "text", "placeholder": "to translate..."}

# Documentation:
# @raycast.description Bob is best translate App on macOS.It's free and opensouce.This script make Raycast integrate with Bob.
# @raycast.author Jax0rz
# @authorURL https://github.com/Jax0rz

on run argv
  tell application "Bob"
    launch
    set targetWord to item 1 of argv
    translate targetWord
  end tell
end run
