#!/usr/bin/env bash
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

# How to use this script?
# It's a template which needs further setup. Duplicate the file,
# remove `.template.` from the filename and set `VPN_NAME` variable.

# 🚨 Set name of your VPN Config from System Preferences
export VPN_NAME="VPN_NAME_FROM_SYSTEM_PREFERENCES"

if [ -z "$VPN_NAME" ]; then
  echo "\$VPN_NAME is empty";
  echo "Please, rename it in \"vpn-config.sh\".";
  exit 1;
fi

if ! command -v vpnutil &> /dev/null; then
  echo "vpnutil is required (https://github.com/Timac/VPNStatus/releases/latest).";
  exit 1;
fi
