#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Connect
# @raycast.mode compact

# Optional parameters:
# @raycast.icon 📡

# @Documentation:
# @raycast.packageName VPN
# @raycast.description Start VPN connection.
# @raycast.author Alexandru Turcanu
# @raycast.authorURL https://github.com/Pondorasti


source vpn-config.sh
VPN=$VPN_NAME

# Source: https://superuser.com/a/736859
function isnt_connected () {
    scutil --nc status "$VPN" | sed -n 1p | grep -qv Connected
}

function poll_until_connected () {
    let loops=0 || true
    let max_loops=200 # 200 * 0.1 is 20 seconds. Bash doesn't support floats

    while isnt_connected "$VPN"; do
        sleep 0.1 # can't use a variable here, bash doesn't have floats
        let loops=$loops+1
        [ $loops -gt $max_loops ] && break
    done

    [ $loops -le $max_loops ]
}

networksetup -connectpppoeservice "$VPN"

if poll_until_connected "$VPN"; then
    echo "Connected to $VPN!"
else
    echo "Couldn't connect to $VPN"
    scutil --nc stop "$VPN"
    exit 1;
fi
