#!/bin/bash

# Dependencies:
#   1. The Bitwarden CLI: https://bitwarden.com/help/article/cli/
#   2. The `jq` utility: https://stedolan.github.io/jq/
#
# Install via homebrew: `brew install bitwarden-cli jq`

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Copy First Password
# @raycast.mode silent
#
# Optional parameters:
# @raycast.packageName Bitwarden
# @raycast.icon images/bitwarden.png
# @raycast.argument1 { "type": "text", "placeholder": "Query" }
#
# Documentation
# @raycast.author Phil Salant
# @raycast.authorURL https://github.com/PSalant726
# @raycast.description Search all items in a Bitwarden vault, and copy the password of the first matching item to the clipboard.

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

item=$(bw get item $1 $session 2> /dev/null | jq ". | { name: .name, password: .login.password }")
name=$(echo $item | jq ".name")
password=$(echo $item | jq -r ".password")

if [[ -z $name || -z $password ]]; then
  echo "The query '$1' did not return a password."
  exit 1
fi

echo $password | pbcopy
echo "Copied the password for '$name' to the clipboard."
exit 0
