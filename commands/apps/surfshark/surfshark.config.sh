#!/bin/bash

# You can find the VPN name in the Network preference pane 
export SURFSHARK_VPN_NAME="Surfshark. IKEv2"

if ! command -v vpnutil &> /dev/null; then
  echo "vpnutil command is required. Download here: https://github.com/Timac/VPNStatus/releases/tag/1.0";
  exit 1;
fi

if [ -z "$SURFSHARK_VPN_NAME" ]; then
  echo "\$SURFSHARK_VPN_NAME is empty. Please, set VPN name in \"surfshark.config.sh\".";
  exit 1;
fi
