#!/bin/bash

# Dependencies:
#   1. The Bitwarden CLI: https://bitwarden.com/help/article/cli/
#   2. The `jq` utility: https://stedolan.github.io/jq/
#
# Install via homebrew: `brew install bitwarden-cli jq`

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Search Vault Items
# @raycast.mode fullOutput
#
# Optional parameters:
# @raycast.packageName Bitwarden
# @raycast.icon images/bitwarden.png
# @raycast.argument1 { "type": "text", "placeholder": "Query" }
# @raycast.argument2 { "type": "text", "placeholder": "Include Passwords? (y/n)", "optional": true }
#
# Documentation
# @raycast.author Phil Salant
# @raycast.authorURL https://github.com/PSalant726
# @raycast.description Search all items in a Bitwarden vault.

if ! command -v bw &> /dev/null; then
  echo "The Bitwarden CLI is not installed (https://bitwarden.com/help/article/cli/)."
  echo "Install via Homebrew with 'brew install bitwarden-cli'"
  exit 1
elif ! command -v jq &> /dev/null; then
  echo "The jq utility is not installed (https://stedolan.github.io/jq/)."
  echo "Install via Homebrew with 'brew install jq'"
  exit 1
fi

token=$(security find-generic-password -a ${USER} -s raycast-bitwarden -w 2> /dev/null)
token_status=$?

session_args=""
if [ $token_status -eq 0 ]; then
  session_args="--session $token"
fi

bw unlock --check $session_args > /dev/null 2>&1
unlocked_status=$?

if [ $unlocked_status -ne 0 ]; then
  echo "Vault is locked. Use the 'Log In' or 'Unlock' commands to enable searching."
  exit 0
fi

password=""
fields=", fields: [[.fields[]? | select(.type != 1)][]? | { name, value }]"
if [[ -n $2 && $2 == "y" ]]; then
  password="password: .login.password,"
  fields=", fields: [.fields[]? | { name, value }]"
fi

output_format="{ name, username: .login.username, $password uris: [.login.uris[]?.uri], lastUpdated: .revisionDate, notes $fields }"
bw list items $session_args --search "$1" | jq --color-output "map($output_format)"
