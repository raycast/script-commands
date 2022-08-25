#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Reconnect
# @raycast.mode silent
#
# Optional parameters:
# @raycast.packageName Mullvad
# @raycast.icon images/mullvad.png
#
# Documentation:
# @raycast.author Phil Salant
# @raycast.authorURL https://github.com/PSalant726
# @raycast.description Force the client to reconnect to the Mullvad VPN tunnel.
#
# Dependencies:
# The Mullvad CLI: https://mullvad.net/en/help/cli-command-wg/

if ! command -v mullvad &> /dev/null; then
  echo "The Mullvad CLI is not installed"
  exit 1
fi

mullvad reconnect --wait

success=$?
if [ $success -ne 0 ]; then
  echo "Failed to reconnect to the VPN tunnel"
  exit 1
fi

status=$(mullvad status --location)
if [[ $status == *"Tunnel status: Disconnected"* ]]; then
  echo "No active connection to reconnect!"
  exit 0
fi

echo "$status"
