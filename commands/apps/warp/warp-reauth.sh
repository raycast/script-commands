#!/bin/bash

# Dependency: Cloudflare WARP https://developers.cloudflare.com/warp-client/setting-up/macOS
# Note: Cloudflare WARP must be installed, but CLI works properly only if GUI-client is not running

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Reauthenticate
# @raycast.mode compact

# Optional parameters:
# @raycast.icon images/warp.png

# @Documentation:
# @raycast.packageName WARP
# @raycast.description Force WARP reauthentication
# @raycast.author Daniils Petrovs
# @raycast.authorURL https://github.com/danirukun


if ! command -v warp-cli &> /dev/null; then
  echo "WARP is required (https://developers.cloudflare.com/warp-client/setting-up/macOS)";
  exit 1;
fi

warp-cli access-reauth
echo "Opening WARP authentication page"
