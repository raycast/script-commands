#!/usr/bin/env bash

# Name of your VPN Config from System Preferences
export VPN_NAME=""

if [ -z "$VPN_NAME" ]; then
  echo "\$VPN_NAME is empty";
  echo "Please, rename it in \"vpn-config.sh\".";
  exit 1;
fi
