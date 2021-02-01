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

passwords=""
if [[ -n $2 && $2 == "y" ]]; then
  passwords="password: .login.password,"
fi

output_format="{ name: .name, username: .login.username, $passwords uris: [.login.uris[]?.uri], lastUpdated: .revisionDate, notes: .notes, fields: .fields }"
bw list items $session_args --search "$1" | jq ".[] | $output_format"
