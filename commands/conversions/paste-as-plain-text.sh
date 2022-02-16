#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Paste as Plain Text
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 📋
# @raycast.packageName Conversions

# Documentation:
# @raycast.author Michael Bianco
# @raycast.authorURL https://github.com/iloveitaly

pbpaste | pbcopy
osascript -e 'tell application "System Events" to keystroke "v" using command down'