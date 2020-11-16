#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Generate UUID
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 💻

uuidgen | pbcopy
echo "UUID Generated"
