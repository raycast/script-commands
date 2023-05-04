#!/bin/bash

# Dependency: This script requires `jq` cli installed: https://stedolan.github.io/jq/
# Install via homebrew: `brew install jq`
# I made this thanks to article by htnosm below
# https://htnosm.hatenablog.com/entry/2023/04/02/090000

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Check Usage of OpenAI API
# @raycast.mode inline
# @raycast.packageName System

#
# Optional parameters:
# @raycast.icon 💲
#
# Documentation:
# @raycast.description Get total usage of OpenAI API
# @raycast.author nagauta
# @raycast.authorURL https://github.com/nagauta

_ORGANIZATION=""
_OPENAI_APIKEY=""

_START_DATE="$(date -u +'%Y-%m')-01"
_END_DATE="$(date -u -v+1m +'%Y-%m')-01"
echo 
TOTAL_USAGE=$(curl -sSf "https://api.openai.com/dashboard/billing/usage?end_date=${_END_DATE}&start_date=${_START_DATE}" \
-H "authorization: Bearer ${_OPENAI_APIKEY}" \
| jq -r '"$" + (.total_usage | round / 100 | tostring)')

echo "Total Usage: ${TOTAL_USAGE}, Period: ${_START_DATE}-${_END_DATE}"