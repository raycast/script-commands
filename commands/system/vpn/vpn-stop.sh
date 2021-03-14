#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Disconnect
# @raycast.mode compact

# Optional parameters:
# @raycast.icon 📡

# @Documentation:
# @raycast.packageName VPN
# @raycast.description Stop VPN connection.
# @raycast.author Alexandru Turcanu
# @raycast.authorURL https://github.com/Pondorasti


source vpn-config.sh
VPN=$VPN_NAME

networksetup -disconnectpppoeservice "$VPN"

echo "Disconnected from $VPN!"
