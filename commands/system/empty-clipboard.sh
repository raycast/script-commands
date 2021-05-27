#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Empty Clipboard
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 📋
# @raycast.packageName System

# Documentation:
# @raycast.description Empty Clipboard

/usr/bin/pbcopy < /dev/null
echo "Clipboard emptied"
