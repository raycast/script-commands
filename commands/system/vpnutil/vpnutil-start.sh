#!/bin/bash
# Based on https://github.com/raycast/script-commands/tree/master/commands/system/vpn

# Depends on vpnutil: https://github.com/Timac/VPNStatus/releases/latest
# Installation:
#   1. Download vpnutil.zip
#   2. Uncompress
#   3. Move vpnutil to /usr/local/bin
#   4. Run manually once to bypass GateKeeper protection:
#      - Right-click the app in the Finder
#      - Select Open
#      - Click on the Open button

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Start VPN
# @raycast.mode compact

# Optional parameters:
# @raycast.icon 📡

# @Documentation:
# @raycast.packageName VPN
# @raycast.description Start VPN connection.
# @raycast.author Sergey Fuksman
# @raycast.authorURL https://github.com/fuksman

CONFIG=vpnutil-config.sh

if [ ! -f $CONFIG ]; then
    echo "Create a vpn-config.sh from template!"
    exit 1
fi

# shellcheck source=/dev/null
source $CONFIG
VPN=$VPN_NAME

# Source: https://superuser.com/a/736859
function isnt_connected () {
    vpnutil status "$VPN" | sed -n 1p | grep -qv Connected
}

function poll_until_connected () {
    (( loops=0 ))
    (( max_loops=200 )) # 200 * 0.1 is 20 seconds. Bash doesn't support floats

    while isnt_connected "$VPN"; do
        sleep 0.1 # can't use a variable here, bash doesn't have floats
        (( loops=loops+1 ))
        [ "$loops" -gt "$max_loops" ] && break
    done

    [ "$loops" -le "$max_loops" ]
}

vpnutil start "$VPN"

if poll_until_connected "$VPN"; then
    echo "Connected to $VPN!"
else
    echo "Couldn't connect to $VPN"
    vpnutil stop "$VPN"
    exit 1;
fi
