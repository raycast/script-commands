#!/bin/bash

# How to use this script?
# It's a template which needs further setup. Duplicate the file,
# remove `.template.` from the filename, and set the name of
# your VPN config from System Preferences.


# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title VPN Disconnect
# @raycast.mode compact

# Optional parameters:
# @raycast.icon 📡

# @Documentation:
# @raycast.packageName System
# @raycast.description Stop VPN connection.
# @raycast.author Alexandru Turcanu
# @raycast.authorURL https://github.com/Pondorasti


# Configuration

# Name of your VPN Config
VPN="VPN (IKEv2)"


# Main program

networksetup -disconnectpppoeservice "$VPN"

echo "Disconnected from $VPN!"
