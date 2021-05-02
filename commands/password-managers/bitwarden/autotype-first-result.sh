#!/bin/bash

# Dependencies:
#   1. The Bitwarden CLI: https://bitwarden.com/help/article/cli/
#   2. The `jq` utility: https://stedolan.github.io/jq/
#
# Install via homebrew: `brew install bitwarden-cli jq`
# or via macports: `sudo port install bitwarden-cli jq`

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Autotype First Result
# @raycast.mode silent

# Optional parameters:
# @raycast.packageName Bitwarden
# @raycast.icon images/bitwarden.png
# @raycast.argument1 { "type": "text", "placeholder": "Query" }

# Documentation:
# @raycast.author Marcel Bochtler
# @raycast.authorURL https://github.com/MarcelBochtler
# @raycast.description Type the username and password of the first Bitwarden result. Separated by one {TAB}.

notFound() {
  echo "The query '$1' did not return a result."
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

item=$(bw list items --search "$1" $session 2> /dev/null | jq ".[0] | { name: .name, username: .login.username, password: .login.password }")
name=$(echo $item | jq --exit-status ".name") || notFoundError
username=$(echo $item | jq --raw-output --exit-status ".username") || notFoundError
password=$(echo $item | jq --raw-output --exit-status ".password") || notFoundError

# TODO: This requires that the username text field to be selected.
# It might be possible to check if a text field is selected before starting to type.
osascript <<EOF
    tell application "System Events"
        keystroke "$username"
        key code 48
        keystroke "$password"
    end tell
EOF

unset item
unset username
unset password

echo "Autotyped username and password for $name."
