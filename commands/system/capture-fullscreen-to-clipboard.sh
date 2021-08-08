#!/bin/sh

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Capture Fullscreen to Clipboard
# @raycast.mode silent
# @raycast.packageName System
#
# Optional parameters:
# @raycast.icon 💻
#
# Documentation:
# @raycast.description This script screenshots the entire screen and saves it to the clipboard.
# @raycast.author Aaron Miller
# @raycast.authorURL https://github.com/aaronhmiller

screencapture -c
echo "Screenshot saved to clipboard"
