#!/usr/bin/osascript

# @raycast.title Create Event
# @raycast.author Robert Cooper
# @raycast.authorURL https://github.com/robertcoopercode
# @raycast.description Create an event in Fantastical
# @raycast.schemaVersion 1

# @raycast.icon ./images/fantastical.png
# @raycast.mode silent
# @raycast.packageName Fantastical
# @raycast.argument1 { "type": "text", "placeholder": "query" }

on run argv 
  tell application "Fantastical"
    parse sentence of (item 1 of argv)
  end tell
end run