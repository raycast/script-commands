#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Decode Base64
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 💻

pbpaste | base64 -d | pbcopy
echo "Decoded"
