#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Connect
# @raycast.mode silent
#
# Optional parameters:
# @raycast.packageName Mullvad
# @raycast.icon images/mullvad.png
#
# Documentation:
# @raycast.author Phil Salant
# @raycast.authorURL https://github.com/PSalant726
# @raycast.description Connect the Mullvad VPN tunnel using the most recent configuration settings.
#
# Dependencies:
# The Mullvad CLI: https://mullvad.net/en/help/cli-command-wg/

if ! command -v mullvad &> /dev/null; then
  echo "The Mullvad CLI is not installed"
  exit 1
fi

mullvad connect --wait

success=$?
if [ $success -ne 0 ]; then
  echo "Failed to establish a VPN tunnel"
  exit 1
fi

status=$(mullvad status)
echo "$status"
