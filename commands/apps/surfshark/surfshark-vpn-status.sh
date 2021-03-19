#!/bin/bash

# Dependency: This script requires the vpnutil commandline utility
# Download and install in your $PATH: https://github.com/Timac/VPNStatus/releases/tag/1.0

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

source surfshark.config.sh
VPN=$SURFSHARK_VPN_NAME

vpnutil status "${VPN}"
