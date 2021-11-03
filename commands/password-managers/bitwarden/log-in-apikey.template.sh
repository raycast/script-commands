#!/bin/bash

# Dependency: This script requires the Bitwarden CLI:
# https://bitwarden.com/help/article/cli/
#
# Install via homebrew: `brew install bitwarden-cli`

# These values can be found in the "API Key" section of a web vault:
# https://vault.bitwarden.com/#/settings/account
BW_CLIENTID=""
BW_CLIENTSECRET=""

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Log In
# @raycast.mode silent
#
# Optional parameters:
# @raycast.packageName Bitwarden
# @raycast.icon images/bitwarden.png
# @raycast.argument1 { "type": "text", "placeholder": "Master Password", "secure": true }
#
# Documentation
# @raycast.author Marcel Bochtler
# @raycast.authorURL https://github.com/MarcelBochtler
# @raycast.description Log in to Bitwarden using an API key.

if [ -z "$BW_CLIENTID" ] || [ -z "$BW_CLIENTSECRET" ]; then
  echo "Error: API key not set."
  exit 1
fi

login_token=$(BW_CLIENTID=$BW_CLIENTID BW_CLIENTSECRET=$BW_CLIENTSECRET bw --raw login --apikey)
login_status=$?

if [ $login_status -ne 0 ]; then
  echo $login_token
  exit 1
fi

unlock_token=$(bw --raw unlock "$1")
unlock_status=$?

if [ $unlock_status -eq 0 ]; then
  security add-generic-password -U -a ${USER} -s raycast-bitwarden -j "Bitwarden session token for use with Raycast" -w $unlock_token
  echo "Login successful! Your session is now unlocked."
  exit 0
else
  echo $unlock_token
  exit 1
fi
