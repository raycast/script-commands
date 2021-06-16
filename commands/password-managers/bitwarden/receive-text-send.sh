#!/bin/bash

# Dependencies:
#   1. The Bitwarden CLI: https://bitwarden.com/help/article/cli/
#   2. The `jq` utility: https://stedolan.github.io/jq/
#
# Install via homebrew: `brew install bitwarden-cli jq`

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Receive a Text Send
# @raycast.mode fullOutput
#
# Optional parameters:
# @raycast.packageName Bitwarden
# @raycast.icon images/bitwarden.png
# @raycast.argument1 { "type": "text", "placeholder": "Send URL" }
# @raycast.argument2 { "type": "text", "placeholder": "Password", "optional": true, "secure": true }
# @raycast.argument3 { "type": "text", "placeholder": "Show Hidden Text? (y/n)", "optional": true }
#
# Documentation
# @raycast.author Phil Salant
# @raycast.authorURL https://github.com/PSalant726
# @raycast.description View the content of a text-only Bitwarden Send.

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
  echo "Session is locked. Use the Log In or Unlock command to view a Send."
  exit 1
fi

password=""
if [[ -n $2 ]]; then
  password="--password $2"
fi

send=$(bw send receive --obj $password $session $1)

if [[ $send == *"Invalid password"* ]]; then
  echo $send
  exit 1
fi

name=$(echo "$send" | jq --raw-output ".name")
text=$(echo "$send" | jq --raw-output "if (.text.hidden and (\"$3\" != \"y\")) then \"=== TEXT HIDDEN ===\" else .text.text end")
printf "%s\n\n%s\n" "$name" "$text"
