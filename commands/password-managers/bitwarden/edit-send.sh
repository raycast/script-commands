#!/bin/bash

# Dependencies:
#   1. The Bitwarden CLI: https://bitwarden.com/help/article/cli/
#   2. The `jq` utility: https://stedolan.github.io/jq/
#
# Install via homebrew: `brew install bitwarden-cli jq`

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Edit a Send
# @raycast.mode fullOutput
#
# Optional parameters:
# @raycast.packageName Bitwarden
# @raycast.icon images/bitwarden.png
# @raycast.argument1 { "type": "text", "placeholder": "Send ID" }
# @raycast.argument2 { "type": "text", "placeholder": "Attribute" }
# @raycast.argument3 { "type": "text", "placeholder": "New Value" }
#
# Documentation
# @raycast.author Phil Salant
# @raycast.authorURL https://github.com/PSalant726
# @raycast.description Edit an existing Bitwarden Send.

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
  echo "Session is locked. Use the Log In or Unlock command to edit a Send."
  exit 1
fi

send=$(bw send get $1 $session 2> /dev/null)
send_status=$?

if [ $send_status -ne 0 ]; then
  printf "No send found with ID '%s'" $1
  exit 1
fi

update=""
case $2 in
  "")
    echo "Please provide an attribute to update"
    exit 1
    ;;
  "id")
    echo "Updating a Send's ID is not supported"
    exit 1
    ;;
  "text")
    update=".text.text=\"$3\""
    ;;
  "hidden")
    update=".text.hidden=\"$3\""
    ;;
  "url")
    update=".accessUrl=\"$3\""
    ;;
  *)
    update=".$2"
    ;;
esac

$send | jq "$update" | bw encode | bw send edit $session | jq --color-output
