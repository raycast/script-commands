#!/usr/bin/env bash

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
# @raycast.argument1 { "type": "text", "placeholder": "Command (default: toggle)", "optional": true, "percentEncoded": true }
#
# @Documentation:
# @raycast.description Do Not Disturb
# @raycast.author Antonio Dal Sie
# @raycast.authorURL https://github.com/exodusanto

cmd=${1:-"toggle"}

if [[ "$cmd" != "on" && "$cmd" != "off" && "$cmd" != "toggle" ]]; then
  echo "Unsupported command: $1 (must be [on/off/toggle])"
  exit 1
fi

calm-notifications $cmd
echo "Do Not Disturb $(calm-notifications status)"
