#!/usr/bin/osascript

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Toggle Natural Scrolling
# @raycast.mode silent
# @raycast.packageName System

# Optional parameters:
# @raycast.icon 🖱
# @raycast.author Wiley Marques
# @raycast.authorURL https://twitter.com/wileymarques
# @raycast.description Script Command to change natural trackpad/mouse scrolling setting. Reverting the setting value each time.

tell application "System Preferences"
  activate
  set current pane to pane "com.apple.preference.trackpad"
end tell

delay 0.6

tell application "System Events"
  tell process "System Preferences"
    click radio button 2 of tab group 1 of window "Trackpad"
    click checkbox 1 of tab group 1 of window "Trackpad"
  end tell
end tell

tell application "System Preferences" to quit
