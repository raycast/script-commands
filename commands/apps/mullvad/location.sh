#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Connect to Location
# @raycast.mode silent
#
# Optional parameters:
# @raycast.packageName Mullvad
# @raycast.icon images/mullvad.png
# @raycast.argument1 { "type": "text", "placeholder": "Country (2-letter code)" }
# @raycast.argument2 { "type": "text", "placeholder": "City (3-letter code)", "optional": true }
# @raycast.argument3 { "type": "text", "placeholder": "Hostname", "optional": true }
#
# Documentation:
# @raycast.author Phil Salant
# @raycast.authorURL https://github.com/PSalant726
# @raycast.description Connect the Mullvad VPN tunnel using the specified location.
#
# Dependencies:
# The Mullvad CLI: https://mullvad.net/en/help/cli-command-wg/

if ! command -v mullvad &> /dev/null; then
  echo "The Mullvad CLI is not installed"
  exit 1
fi

location=$(mullvad relay set location "$@" 2>&1)
location_set=$?

if [ $location_set -ne 0 ]; then
  echo "${location//error: /}"
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
