#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title VPN Connect
# @raycast.mode compact
# @raycast.packageName Surfshark

# Optional parameters:
# @raycast.icon images/surfshark.png
# @raycast.author Jordi Clement
# @raycast.authorURL https://github.com/jordicl
# @raycast.description Start Surfshark VPN connection

source surfshark.config.sh
VPN=$SURFSHARK_VPN_NAME

vpnutil start "${VPN}" >/dev/null 2>&1
echo "Surfshark VPN connected"
