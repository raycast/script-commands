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

# You can find the VPN name in the Network preference pane 
VPN="Surfshark. IKEv2"

if ! command -v vpnutil &> /dev/null; then
	echo "vpnutil command is required. Download here: https://github.com/Timac/VPNStatus/releases/tag/1.0";
	exit 1;
fi

# 
vpnutil start "${VPN}" >/dev/null 2>&1
echo "Surfshark VPN connected"
