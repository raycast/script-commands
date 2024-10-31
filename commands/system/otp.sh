#!/bin/bash

# Dependency: This script requires `apw`, `jq` and `awk` to be installed and in $PATH
#
# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title One-Time Password
# @raycast.mode silent
#
# Optional parameters:
# @raycast.icon 🔑
# @raycast.packageName System
# @raycast.argument1 { "type": "text", "placeholder": "Domain" }
# @raycast.argument2 { "type": "text", "placeholder": "Username Index", "optional": true }
#
# @raycast.description Get One-Time Password (OTP) from Apple Password Manager
# @raycast.author Angelos Michalopoulos
# @raycase.authorURL https://github.com/miagg

if ! command -v apw &> /dev/null || ! command -v jq &> /dev/null || ! command -v awk &> /dev/null; then
    echo "This function requires apw, jq and awk to be installed"
    exit 1
fi
UINDEX=$((${2:-1} - 1))
CODES=$(apw otp get "$1" 2>/dev/null)
STATUS=$?
# ✋ If return code 9, not authenticated, run apw auth
if [ $STATUS -eq 9 ]; then
    echo "Please authenticate first by running 'apw auth'"
    exit 1
fi
# ✋ If return code 3, domain not found, alert user
if [ $STATUS -eq 3 ]; then
    echo "Domain $1 not found"
    exit 1
fi
# Grab available OTP codes for domain
CODES_COUNT=$(echo $CODES | jq '.results | length')
if [ $CODES_COUNT -gt 1 ]; then
    CODE=$(echo $CODES | jq -r ".results[$UINDEX].code")
    USERNAME=$(echo $CODES | jq -r ".results[$UINDEX].username")
    if [ "$CODE" == "null" ]; then
        echo "Please provide an index between 1 and $CODES_COUNT"
        exit 1
    fi
else
    CODE=$(echo $CODES | jq -r '.results[0].code')
    USERNAME=$(echo $CODES | jq -r ".results[0].username")
fi
echo $CODE | pbcopy
echo "OTP code for $USERNAME copied to clipboard"