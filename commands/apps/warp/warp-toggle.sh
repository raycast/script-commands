#!/bin/bash

# Dependency: Cloudflare WARP https://developers.cloudflare.com/warp-client/setting-up/macOS
# Note: Cloudflare WARP must be installed, but CLI works properly only if GUI-client is not running

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Toggle WARP
# @raycast.mode compact

# Optional parameters:
# @raycast.icon images/warp.png

# @Documentation:
# @raycast.packageName WARP
# @raycast.description Toggle Connection
# @raycast.author Sergey Fuksman
# @raycast.authorURL https://github.com/fuksman


if ! command -v warp-cli &> /dev/null; then
  echo "WARP is required (https://developers.cloudflare.com/warp-client/setting-up/macOS)";
  exit 1;
fi

# Source: https://superuser.com/a/736859
function isnt_connected () {
    warp-cli status | sed -n 2p | grep -qv Connected
}

function poll_until_connected () {
    (( loops=0 ))
    (( max_loops=200 )) # 200 * 0.1 is 20 seconds. Bash doesn't support floats

    while isnt_connected; do
        sleep 0.1 # can't use a variable here, bash doesn't have floats
        (( loops=loops+1 ))
        [ "$loops" -gt "$max_loops" ] && break
    done

    [ "$loops" -le "$max_loops" ]
}

if isnt_connected; then
    warp-cli connect
    if poll_until_connected; then
        echo "Connected to WARP"
    else
        echo "Couldn't connect to WARP"
        warp-cli disconnect
        exit 1
    fi
else
    warp-cli disconnect
    echo "Disconnected from WARP"
fi