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

osascript -e 'set clipboardContent to the clipboard' \
-e 'delay 0.2' \
-e 'set charCount to count of characters of clipboardContent' \
-e 'tell application "System Events"' \
-e '	repeat with i from 1 to charCount' \
-e '		set theChar to character i of clipboardContent' \
-e '		keystroke theChar' \
-e '	end repeat' \
-e 'end tell'
