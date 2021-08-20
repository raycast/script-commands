#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Disable Caffeinate
# @raycast.mode silent
# @raycast.packageName System
#
# Optional parameters:
# @raycast.icon ☕️
# @raycast.needsConfirmation false
#
# Documentation:
# @raycast.description Stops all caffeinate sessions
# @raycast.author Yan Smaliak
# @raycast.authorURL https://github.com/ysmaliak

killall caffeinate
echo "Disable caffeinate"
