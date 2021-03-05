#!/usr/bin/env bash

# This is a template which needs further setup. Duplicate the file,
# remove `.template.` from the filename, and set the name of
# your VPN config from System Preferences.

# Name of your VPN Config
export VPN_NAME="VPN (IKEv2)"

if [ -z "$VPN_NAME" ]; then
  echo "\$VPN_NAME is empty";
  exit 1;
fi
