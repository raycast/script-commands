#!/bin/bash

# Dependency: This script requires the Bitwarden CLI:
# https://bitwarden.com/help/article/cli/
#
# Install via homebrew: `brew install bitwarden-cli`

# IMPORTANT:
# You must first authenticate your vault using the `Log In` script
# before this script will work as expected. Note that using the
# `Log In` script will automatically unlock the vault in addition
# to authenticating.
#
# Use this script only for unlocking an authenticated, but locked,
# vault. You can check your vault's authentication and lock status
# using the `Vault Status` command.

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Unlock Vault
# @raycast.mode silent
#
# Optional parameters:
# @raycast.packageName Bitwarden
# @raycast.icon images/bitwarden.png
# @raycast.argument1 { "type": "text", "placeholder": "Master Password" }
#
# Documentation
# @raycast.author Phil Salant
# @raycast.authorURL https://github.com/PSalant726
# @raycast.description Unlock an authenticated Bitwarden vault.

if ! command -v bw &> /dev/null; then
  echo "The Bitwarden CLI is not installed."
  exit 1
fi

out=$(bw --raw unlock $1)
status=$?

if [ $status -eq 0 ]; then
  security add-generic-password -U -a ${USER} -s raycast-bitwarden -j "Bitwarden session token for use with Raycast" -w $out
  unset $out
  echo "Your vault is now unlocked!"
  exit 0
else
  echo $out
  exit 1
fi
