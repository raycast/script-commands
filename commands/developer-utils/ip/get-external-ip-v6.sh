#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title External IPv6
# @raycast.mode inline
# @raycast.packageName Internet

# Optional parameters:
# @raycast.icon 🌐

# Documentation:
# @raycast.description Copies the external IPv6 to the clipboard.

ip=$(curl -6 -s -m 5 https://api64.ipify.org)
echo $ip | tr -d '\n' | pbcopy
echo "Copied $ip"
