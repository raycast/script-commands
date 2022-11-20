#!/bin/bash

# Dependency: Cloudflare WARP https://developers.cloudflare.com/warp-client/setting-up/macOS
# Note: Cloudflare WARP must be installed, but CLI works properly only if GUI-client is not running

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title WARP Status
# @raycast.mode inline
# @raycast.refreshTime 30s

# Optional parameters:
# @raycast.icon images/warp.png

# @Documentation:
# @raycast.packageName WARP
# @raycast.description Check WARP connection
# @raycast.author Sergey Fuksman
# @raycast.authorURL https://github.com/fuksman

if ! command -v warp-cli &> /dev/null; then
  echo "WARP is required (https://developers.cloudflare.com/warp-client/setting-up/macOS)";
  exit 1;
fi

status=$(warp-cli status | grep Status | awk 'NF>1{print $NF}')

if [ "$status" == "Connected" ] || [ "$status" == "Disconnected" ]; then
  echo "$status"
  exit 0
fi

echo "🚨 Can't check status"
exit 1
