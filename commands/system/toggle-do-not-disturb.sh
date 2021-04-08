#!/bin/bash

# Dependency: This script requires `calm-notifications` cli installed: https://github.com/vitorgalvao/tiny-scripts/blob/master/calm-notifications
# Install via homebrew: `brew install vitorgalvao/tiny-scripts/calm-notifications`

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Toggle Do Not Disturb
# @raycast.mode compact
#
# Optional parameters:
# @raycast.icon 🔕
# @raycast.packageName System
#
# @Documentation:
# @raycast.description Toggle Do Not Disturb
# @raycast.author Antonio Dal Sie
# @raycast.authorURL https://github.com/exodusanto

if [ "on" = $(calm-notifications status) ]
then
  calm-notifications off
  # Wait 2s for status bar apply
  sleep 2
  echo "Do Not Disturb off"
else
  calm-notifications on
  echo "Do Not Disturb on"
fi
