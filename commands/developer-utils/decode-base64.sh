#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Decode Base64
# @raycast.mode silent
# @raycast.packageName Developer Utilities

# Optional parameters:
# @raycast.icon 💻

pbpaste | base64 -d | pbcopy
echo "Decoded"
