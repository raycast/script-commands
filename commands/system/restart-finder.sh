#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Restart the Finder
# @raycast.mode silent
# @raycast.packageName System

# Optional parameters:
# @raycast.icon 💀
# @raycast.author Jordi Clement
# @raycast.authorURL https://github.com/jordicl

# Documentation:
# @raycast.description Restart the Finder

killall Finder

echo "Restarted the Finder"
