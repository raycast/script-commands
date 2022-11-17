#!/bin/bash

# Dependencies:
#   1. The Bitwarden CLI: https://bitwarden.com/help/article/cli/
#   2. The `jq` utility: https://stedolan.github.io/jq/
#
# Install via homebrew: `brew install bitwarden-cli jq`

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title List All Text Sends
# @raycast.mode fullOutput
#
# Optional parameters:
# @raycast.packageName Bitwarden
# @raycast.icon images/bitwarden.png
# @raycast.argument1 { "type": "text", "placeholder": "Show Hidden Text? (y/n)", "optional": true }
#
# Documentation
# @raycast.author Phil Salant
# @raycast.authorURL https://github.com/PSalant726
# @raycast.description List all Bitwarden text Sends created in the currently unlocked account.

if ! command -v bw &> /dev/null; then
  echo "The Bitwarden CLI is not installed."
  exit 1
elif ! command -v jq &> /dev/null; then
  echo "The jq utility is not installed."
  exit 1
fi

token=$(security find-generic-password -a ${USER} -s raycast-bitwarden -w 2> /dev/null)
token_status=$?

session=""
if [ $token_status -eq 0 ]; then
  session="--session $token"
fi

bw unlock --check $session > /dev/null 2>&1
unlocked_status=$?

if [ $unlocked_status -ne 0 ]; then
  echo "Session is locked. Use the Log In or Unlock command to list Sends."
  exit 1
fi

bw sync $session > /dev/null 2>&1

text_content="(if (.text.hidden and (\"$1\" != \"y\")) then \"=== TEXT HIDDEN ===\" else .text.text end)"
output_format="{ name, id, text: $text_content, deletionDate, expirationDate, maxAccessCount, accessCount, passwordSet, notes, url: .accessUrl }"
bw send list $session | jq --color-output "map($output_format)"
