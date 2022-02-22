#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Copy Current Page URL
# @raycast.mode silent
# @raycast.packageName Safari
#
# Optional parameters:
# @raycast.icon 🧭
#
# Documentation:
# @raycast.description This script copies URL of currently opened page in Safari into clipboard.
# @raycast.author Kirill Gorbachyonok
# @raycast.authorURL https://github.com/japanese-goblinn

osascript -e 'tell application "Safari" to return URL of front document' | tr -d '[:space:]' | pbcopy
echo "Copied URL"
