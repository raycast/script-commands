#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Encode Base64
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 💻

pbpaste | base64 | pbcopy
echo "Encoded"
