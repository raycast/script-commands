#!/bin/bash

# Note: Tailscale v1.8.0 required
# Install via https://tailscale.com/download

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Disconnect
# @raycast.mode silent

# Optional parameters:
# @raycast.icon ./images/tailscale-icon.png
# @raycast.iconDark ./images/tailscale-iconDark.png
# @raycast.packageName Tailscale

# @Documentation:
# @raycast.description Disconnects from Tailscale
# @raycast.author Ross Zurowski
# @raycast.authorURL https://github.com/rosszurowski

ts=""

if command -v tailscale &> /dev/null; then
  ts=$(which tailscale)
elif [ -f /Applications/Tailscale.app/Contents/MacOS/Tailscale ]; then
  ts="/Applications/Tailscale.app/Contents/MacOS/Tailscale"
else
  echo "Tailscale is not installed. See: tailscale.com/download"
  exit 1
fi

$ts down
echo "Disconnected"
