#!/bin/bash

# Note: Tailscale v1.8.0 required
# Install via https://tailscale.com/download

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Switch Account
# @raycast.mode silent

# Optional parameters:
# @raycast.icon ./images/tailscale-icon.png
# @raycast.iconDark ./images/tailscale-iconDark.png
# @raycast.packageName Tailscale

# @Documentation:
# @raycast.description Switches Tailscale networks

# Original author
# @raycast.author Ross Zurowski
# @raycast.authorURL https://github.com/rosszurowski

# Contributor
# @raycast.author Daniel Schoemer
# @raycast.authorURL https://github.com/quatauta

ts=""

if command -v tailscale &> /dev/null; then
  ts=$(which tailscale)
elif [ -f /Applications/Tailscale.app/Contents/MacOS/Tailscale ]; then
  ts="/Applications/Tailscale.app/Contents/MacOS/Tailscale"
else
  echo "Tailscale is not installed. See tailscale.com/download"
  exit 1
fi

"${ts}" switch --list |     # List all Tailscale accounts "<ID>  <Tailnet name>  <User account name>"
grep -vF -e 'ID' -e '*' |   # Omit the header line and the current account marked with "*"
awk '{ print $1 }' |        # Print only the account ID of not-connected accounts
head -n1 |                  # Print only the first not-connected account
xargs -r -n1 "${ts}" switch # Switch to the selected account

tailnet="$("${ts}" switch --list | awk '/\*/ { print $2 }')"
echo "Switched to ${tailnet}"
