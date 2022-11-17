#!/bin/bash

# Dependencies:
#   1. The Bitwarden CLI: https://bitwarden.com/help/article/cli/
#   2. The `jq` utility: https://stedolan.github.io/jq/
#
# Install via homebrew: `brew install bitwarden-cli jq`

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Copy First Matching TOTP
# @raycast.mode silent
#
# Optional parameters:
# @raycast.packageName Bitwarden
# @raycast.icon images/bitwarden.png
# @raycast.argument1 { "type": "text", "placeholder": "Query" }
#
# Documentation
# @raycast.author Adrian Reyes
# @raycast.author Phil Salant
# @raycast.authorURL https://github.com/int3rrupt
# @raycast.description Search all items in a Bitwarden vault, and copy the TOTP of the first search result to the clipboard.

itemNotFound() {
  echo "The query '${BASH_ARGV[0]}' did not return any items."
  exit 1
}

totpNotFound() {
  echo "The item '$1' does not have a TOTP configured."
  exit 1
}

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
  echo "Vault is locked!"
  exit 1
fi

item=$(bw list items --search "$1" $session 2> /dev/null | jq ".[0] | { id: .id, name: .name }")
name=$(echo $item | jq --exit-status ".name") || itemNotFound
id=$(echo $item | jq --raw-output --exit-status ".id") || itemNotFound
totp=$(bw get totp $id $session 2> /dev/null)
test $? -eq 0 || totpNotFound "$name"

echo -n $totp | pbcopy
unset totp
echo "Copied the TOTP for '$name' to the clipboard."
exit 0
