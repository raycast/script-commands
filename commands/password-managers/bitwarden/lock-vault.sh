#!/bin/bash

# Dependency: This script requires the Bitwarden CLI:
# https://bitwarden.com/help/article/cli/
#
# Install via homebrew: `brew install bitwarden-cli`

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Lock Vault
# @raycast.mode silent
#
# Optional parameters:
# @raycast.packageName Bitwarden
# @raycast.icon images/bitwarden.png
#
# Documentation
# @raycast.author Phil Salant
# @raycast.authorURL https://github.com/PSalant726
# @raycast.description Lock a Bitwarden vault.

if ! command -v bw &> /dev/null; then
  echo "The Bitwarden CLI is not installed."
  exit 1
fi

security delete-generic-password -a ${USER} -s raycast-bitwarden > /dev/null 2>&1
bw lock
