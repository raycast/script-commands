#!/bin/bash

# Dependency: This script requires `calm-notifications` cli installed: https://github.com/vitorgalvao/tiny-scripts/blob/master/calm-notifications
# Install via homebrew: `brew install vitorgalvao/tiny-scripts/calm-notifications`

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Do Not Disturb
# @raycast.mode compact
#
# Optional parameters:
# @raycast.icon 🔕
# @raycast.packageName System
# @raycast.argument1 { "type": "text", "placeholder": "command", "optional": true, "percentEncoded": true }
#
# @Documentation:
# @raycast.description Do Not Disturb
# @raycast.author Antonio Dal Sie
# @raycast.authorURL https://github.com/exodusanto

echo_status() {
  echo "Do Not Disturb $(calm-notifications status)"
}

off() {
  calm-notifications off
  # Wait 2s for status bar apply
  sleep 2
}

toggle() {
  if [ "on" = $(calm-notifications status) ]
    then
      off
      echo_status
    else
      calm-notifications on
      echo_status
    fi
}

if [ ! $1 ] || [ "toggle" = $1 ]
then
  toggle
elif [ "status" = $1 ]
then
  echo_status
elif [ "off" = $1 ]
then
  off
  echo_status
else
  calm-notifications $1
  echo_status
fi
