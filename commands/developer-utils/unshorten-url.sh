#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Unshorten URL
# @raycast.author Nikita Galaiko
# @raycast.authorURL https://github.com/ngalaiko
# @raycast.mode silent
# @raycast.packageName Developer Utilities

# Optional parameters:
# @raycast.icon 🔗

# Documentation:
# @raycast.description Unshortens clipboard content url and copies the result again.

## Please note that https://unshorten.me has a limit of unique 10 requests per hour:
## https://unshorten.me/api

function resolve() {
    local url_short="${1//+/ }"
    local schema_less="$(sed 's/https\{0,1\}:\/\///g' <<<"${url_short}")"
    local resolved="$(curl --silent https://unshorten.me/s/${schema_less})"
    printf '%b' "${resolved//%/\\x}"
}

resolve $(pbpaste) | pbcopy
echo "URL resolved"
