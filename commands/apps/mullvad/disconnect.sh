#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Disconnect
# @raycast.mode silent
#
# Optional parameters:
# @raycast.packageName Mullvad
# @raycast.icon images/mullvad.png
#
# Documentation:
# @raycast.author Phil Salant
# @raycast.authorURL https://github.com/PSalant726
# @raycast.description Disconnect from the Mullvad VPN tunnel.
#
# Dependencies:
# The Mullvad CLI: https://mullvad.net/en/help/cli-command-wg/

if ! command -v mullvad &> /dev/null; then
  echo "The Mullvad CLI is not installed"
  exit 1
fi

mullvad disconnect --wait

success=$?
if [ $success -ne 0 ]; then
  echo "Failed to disconnect from the VPN tunnel"
  exit 1
fi

echo "Disconnected and unsecured"
