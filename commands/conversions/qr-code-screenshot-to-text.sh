#!/bin/bash

# Dependency: This script requires `jq` cli installed: https://stedolan.github.io/jq/
# Install via homebrew: `brew install jq`

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Screenshot QR Code to Clipboard
# @raycast.mode silent
# @raycast.packageName QR Code
#
# Optional parameters:
# @raycast.icon images/qrcode.icns
# @raycast.currentDirectoryPath ~
# @raycast.needsConfirmation false
#
# Documentation:
# @raycast.description Decode QR Code from screenshot to clipboard using https://qrserver.com/
# @raycast.author Diego Lopes
# @raycast.authorURL https://github.com/Dihgg


if ! command -v jq &> /dev/null; then
    echo  "jq command is required (https://stedolan.github.io/jq/)."
    exit 1
fi

TEMP_DIR=$(mktemp -d)

FILE="$TEMP_DIR/screenshot.png"

screencapture -i "$FILE"

if ! test -f "$FILE"; then
    printf "Please capture a QR code"
    exit 1
fi

curl -s --location --request POST 'https://api.qrserver.com/v1/read-qr-code/' --form file=@"$TEMP_DIR"/screenshot.png >> "$TEMP_DIR"/qr-code.json

DATA=$(jq -r '.[0].symbol[0].data' "$TEMP_DIR/qr-code.json")

if [ "$DATA" == "null"  ]; then    
    ERROR=$(jq .[0].symbol[0].error "$TEMP_DIR/qr-code.json")
    printf "%s" "$ERROR"
    exit 1
fi

echo "$DATA" | pbcopy

printf "Gathered QR Code Content to Clipboard"
exit 0;


