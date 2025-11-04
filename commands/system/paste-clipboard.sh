#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Type Clipboard
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 📋
# @raycast.packageName Type Clipboard in Search

# Documentation:
# @raycast.description Takes your clipboard then types each character in the clipboard
# @raycast.author AlexGadd
# @raycast.authorURL https://raycast.com/AlexGadd

sleep 0.3
#returns "true" or "false" if key is held down
commandKeyDown=$(osascript -l JavaScript -e "ObjC.import('Cocoa'); ($.NSEvent.modifierFlags & $.NSEventModifierFlagCommand) > 1")
controlKeyDown=$(osascript -l JavaScript -e "ObjC.import('Cocoa'); ($.NSEvent.modifierFlags & $.NSEventModifierFlagControl) > 1")
optionKeyDown=$(osascript -l JavaScript -e "ObjC.import('Cocoa'); ($.NSEvent.modifierFlags & $.NSEventModifierFlagOption) > 1")
shiftKeyDown=$(osascript -l JavaScript -e "ObjC.import('Cocoa'); ($.NSEvent.modifierFlags & $.NSEventModifierFlagShift) > 1")
functionKeyDown=$(osascript -l JavaScript -e "ObjC.import('Cocoa'); ($.NSEvent.modifierFlags & $.NSEventModifierFlagFunction) > 1")

keys=("$commandKeyDown" "$controlKeyDown" "$optionKeyDown" "$shiftKeyDown" "$functionKeyDown")

anyPressed=false
for key in "${keys[@]}"; do
  if [[ $key == "true" ]]; then
    anyPressed=true
    break
  fi
done

if $anyPressed; then
osascript -e 'set theAlertText to "Modifier key held"' \
-e 'set theAlertMessage to "To allow this script to function, please ensure you do not hold any modifier keys down while the paste script runs"' \
-e 'display alert theAlertText message theAlertMessage as critical buttons {"OK"} default button "OK"' \
else
osascript -e 'set clipboardContent to the clipboard' \
-e 'set charCount to count of characters of clipboardContent' \
-e 'tell application "System Events"' \
-e '	repeat with i from 1 to charCount' \
-e '		set theChar to character i of clipboardContent' \
-e '		keystroke theChar' \
-e '	end repeat' \
-e 'end tell'
fi
