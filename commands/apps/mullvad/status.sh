#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Mullvad Status
# @raycast.mode inline
#
# Conditional parameters:
# @raycast.refreshTime 5m
#
# Optional parameters:
# @raycast.packageName Mullvad
# @raycast.icon images/mullvad.png
#
# Documentation:
# @raycast.author Phil Salant
# @raycast.authorURL https://github.com/PSalant726
# @raycast.description Display the current status of the Mullvad VPN tunnel connection.
#
# Dependencies:
# The Mullvad CLI: https://mullvad.net/en/help/cli-command-wg/

if ! command -v mullvad &> /dev/null; then
  echo "⚠️  The Mullvad CLI is not installed"
  exit 1
fi

status=$(mullvad status)

success=$?
if [ $success -ne 0 ]; then
  echo "⚠️  Failed to update VPN tunnel connection status"
  exit 1
fi

if [[ $status == *"Disconnected"* ]]; then
  echo "❌  Disconnected and unsecured"
else
  echo "✅  $status"
fi
