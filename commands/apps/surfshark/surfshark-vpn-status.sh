#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Surfshark VPN Status
# @raycast.mode inline
# @raycast.refreshTime 10s
# @raycast.packageName Surfshark

# Optional parameters:
# @raycast.icon images/surfshark.png
# @raycast.author Jordi Clement
# @raycast.authorURL https://github.com/jordicl
# @raycast.description Get Surfshark VPN status

# You can find the VPN name in the Network preference pane 
VPN="Surfshark. IKEv2"

if ! command -v vpnutil &> /dev/null; then
	echo "vpnutil command is required. Download here: https://github.com/Timac/VPNStatus/releases/tag/1.0";
	exit 1;
fi

vpnutil status "${VPN}"
