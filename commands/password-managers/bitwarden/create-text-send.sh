#!/bin/bash

# Dependencies:
#   1. The Bitwarden CLI: https://bitwarden.com/help/article/cli/
#   2. The `jq` utility: https://stedolan.github.io/jq/
#
# Install via homebrew: `brew install bitwarden-cli jq`

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Create a Text Send
# @raycast.mode silent
#
# Optional parameters:
# @raycast.packageName Bitwarden
# @raycast.icon images/bitwarden.png
# @raycast.argument1 { "type": "text", "placeholder": "Text" }
# @raycast.argument2 { "type": "text", "placeholder": "Name", "optional": true }
# @raycast.argument3 { "type": "text", "placeholder": "Password", "optional": true, "secure": true }
#
# Documentation
# @raycast.author Phil Salant
# @raycast.authorURL https://github.com/PSalant726
# @raycast.description Create a new text-only Bitwarden Send.

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
  echo "Session is locked. Use the Log In or Unlock command to create a Send."
  exit 1
fi

filter=(".text.text=\"$1\" | .text.hidden=true | .notes=\"\"")
if [[ -n $2 ]]; then
  filter+=(" | .name=\"$2\"")
fi

if [[ -n $3 ]]; then
  filter+=(" | .password=\"$3\"")
fi

encoded=$(bw send template send.text | jq "$(echo -n "${filter[@]}")" | bw encode)
send=$(bw send create $session $encoded)
send_status=$?

if [ $send_status -ne 0 ]; then
  echo "Failed to create Send"
  exit 1
fi

echo $send | grep -o 'https://send.bitwarden.com/.*' | pbcopy
echo "Send created! It's URL has been copied to the clipboard."
