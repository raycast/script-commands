#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title VPN Disconnect
# @raycast.mode compact
# @raycast.packageName Surfshark

# Optional parameters:
# @raycast.icon images/surfshark.png
# @raycast.author Jordi Clement
# @raycast.authorURL https://github.com/jordicl
# @raycast.description Stop Surfshark VPN connection

source surfshark.config.sh
VPN=$SURFSHARK_VPN_NAME

vpnutil stop "${VPN}" >/dev/null 2>&1
echo "Surfshark VPN disconnected"
