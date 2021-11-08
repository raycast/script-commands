#!/bin/bash
# Based on https://github.com/raycast/script-commands/tree/master/commands/system/vpn

# Dependency: vpnutil https://github.com/Timac/VPNStatus/releases/latest
# Installation:
#   1. Download vpnutil.zip
#   2. Uncompress
#   3. Move vpnutil to /usr/local/bin
#   4. Run manually once to bypass GateKeeper protection:
#      - Right-click the app in the Finder
#      - Select Open
#      - Click on the Open button

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title VPN Status
# @raycast.mode inline
# @raycast.refreshTime 30s

# Optional parameters:
# @raycast.icon 📡

# @Documentation:
# @raycast.packageName VPN
# @raycast.description Check VPN connection
# @raycast.author Sergey Fuksman
# @raycast.authorURL https://github.com/fuksman


CONFIG=vpnutil-config.sh

if [ ! -f $CONFIG ]; then
    echo "Create a vpn-config.sh from template!"
    exit 1
fi

# shellcheck source=/dev/null
source $CONFIG
VPN=$VPN_NAME

status=$(vpnutil status "$VPN" | sed -n 1p | awk 'NF>1{print $NF}')

if [ "$status" == "Connected" ]; then
  echo "$status to $VPN"
  exit 0
fi

echo "$status"
