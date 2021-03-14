#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title VPN Status
# @raycast.mode inline
# @raycast.refreshTime 1m

# Optional parameters:
# @raycast.icon 📡

# @Documentation:
# @raycast.packageName VPN
# @raycast.description Stop VPN connection.
# @raycast.author Alexandru Turcanu
# @raycast.authorURL https://github.com/Pondorasti


source vpn-config.sh
VPN=$VPN_NAME

status=$(scutil --nc status "$VPN" | sed -n 1p)

if [ "$status" == "Connected" ]; then
  echo "$status to $VPN"
  exit 0
fi

echo "$status"
