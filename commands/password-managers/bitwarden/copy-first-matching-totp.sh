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
# @raycast.author Phil Salant
# @raycast.authorURL https://github.com/PSalant726
# @raycast.description Search all items in a Bitwarden vault, and copy the password of the first search result to the clipboard.

# Activate Python environment
if ! command -v virtualenv &> /dev/null
then
    pip3 install virtualenv
fi

if [ ! -d virtualenv ]; then
  virtualenv venv
fi

source venv/bin/activate

if ! command -v mintotp &> /dev/null
then
    pip3 install mintotp
fi

notFound() {
  echo "The query '${BASH_ARGV[0]}' did not return a TOTP."
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

item=$(bw list items --search "$1" $session 2> /dev/null | jq ".[0] | { name: .name, totp: .login.totp }")
name=$(echo $item | jq --exit-status ".name") || notFound
totp=$(echo $item | jq --raw-output --exit-status ".totp") || notFound
totp=$(echo $totp | sed -E "s/^(.)+\?secret=//g" | sed -E "s/&issuer=(.)+//g") || notFound

echo -n $(mintotp <<< $totp) | pbcopy
unset totp
echo "Copied the TOTP for '$name' to the clipboard."
exit 0
