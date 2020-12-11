#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Encode URL
# @raycast.mode silent
# @raycast.packageName Developer Utilities

# Optional parameters:
# @raycast.icon 💻

# Documentation:
# @raycast.description Encodes clipboard content url and copies it again.

pbpaste | ( curl -Gso /dev/null -w %{url_effective} --data-urlencode @- "" | cut -c 3- || true) | pbcopy
echo "Encoded URL"
