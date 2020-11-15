#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Copy Current Page URL
# @raycast.mode silent
#
# Optional parameters:
# @raycast.icon 🧭
# @raycast.packageName Safari
#
# Documentation:
# @raycast.description This script copies URL of currently opened page in Safari into clipboard.
# @raycast.author Kirill Gorbachyonok
# @raycast.authorURL https://github.com/japanese-goblinn

osascript -e 'tell application "Safari" to return URL of front document' | pbcopy
echo "Copied"