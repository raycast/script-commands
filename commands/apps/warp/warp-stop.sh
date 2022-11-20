#!/bin/bash

# Dependency: Cloudflare WARP https://developers.cloudflare.com/warp-client/setting-up/macOS
# Note: Cloudflare WARP must be installed, but CLI works properly only if GUI-client is not running

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Disconnect
# @raycast.mode compact

# Optional parameters:
# @raycast.icon images/warp.png

# @Documentation:
# @raycast.packageName WARP
# @raycast.description Disconnect from WARP
# @raycast.author Sergey Fuksman
# @raycast.authorURL https://github.com/fuksman


if ! command -v warp-cli &> /dev/null; then
  echo "WARP is required (https://developers.cloudflare.com/warp-client/setting-up/macOS)";
  exit 1;
fi

# Source: https://superuser.com/a/736859
function isnt_connected () {
    warp-cli status | grep Status | grep -qv Connected
}


if isnt_connected; then
    echo "WARP is not connected"
    exit 1
else
    warp-cli disconnect
    echo "Disconnected from WARP"
fi
