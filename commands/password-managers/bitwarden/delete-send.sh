#!/bin/bash

# Dependency:
# The Bitwarden CLI: https://bitwarden.com/help/article/cli/
# Install via homebrew: `brew install bitwarden-cli`

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Delete a Send
# @raycast.mode silent
#
# Optional parameters:
# @raycast.packageName Bitwarden
# @raycast.icon images/bitwarden.png
# @raycast.needsConfirmation true
# @raycast.argument1 { "type": "text", "placeholder": "Send ID" }
#
# Documentation
# @raycast.author Phil Salant
# @raycast.authorURL https://github.com/PSalant726
# @raycast.description Delete a Bitwarden Send.

if ! command -v bw &> /dev/null; then
  echo "The Bitwarden CLI is not installed."
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
  echo "Session is locked. Use the Log In or Unlock command to delete a Send."
  exit 1
fi

bw send delete $1 $session 2> /dev/null
delete_status=$?

if [ $delete_status -ne 0 ]; then
  printf "Failed to delete Send with ID '%s'" $1
  exit 1
fi

printf "Deleted Send with ID '%s'" $1
