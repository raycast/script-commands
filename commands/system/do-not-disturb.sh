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

if [[ "$1" != "on" && "$1" != "off" && "$1" != "toggle" ]]; then
  echo "Unsupported parameter value: $1 (must be [on/off/toggle])"
  exit 1
fi

calm-notifications $1
sleep 2
echo "Do Not Disturb $(calm-notifications status)"