#!/bin/bash

# How to use this script?
# It's a template which needs further setup. Duplicate the file,
# remove `.template.` from the filename, and set the name of
# your VPN config from System Preferences.


# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title VPN Status
# @raycast.mode inline
# @raycast.refreshTime 1m

# Optional parameters:
# @raycast.icon 📡

# @Documentation:
# @raycast.packageName Dashboard
# @raycast.description Stop VPN connection.
# @raycast.author Alexandru Turcanu
# @raycast.authorURL https://github.com/Pondorasti


# Configuration

# Name of your VPN Config
VPN="VPN (IKEv2)"


# Main program

status=$(scutil --nc status "$VPN" | sed -n 1p)

echo "$status"
