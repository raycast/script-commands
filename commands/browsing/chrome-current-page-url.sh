#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Copy Current Page URL
# @raycast.mode silent
# @raycast.packageName Google Chrome
#
# Optional parameters:
# @raycast.icon 🧭
#
# Documentation:
# @raycast.description This script copies URL of currently opened page in Google Chrome into clipboard.
# @raycast.author Jakub Lanski
# @raycast.authorURL https://github.com/jaklan

osascript -e 'tell application "Google Chrome" to get URL of active tab of first window' | pbcopy
echo "Copied"
