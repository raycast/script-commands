#!/bin/bash

# Dependency: This script requires the Bitwarden CLI:
# https://bitwarden.com/help/article/cli/
#
# Install via homebrew: `brew install bitwarden-cli`

# IMPORTANT:
# You must first authenticate your session using the `Log In` script
# before this script will work as expected. Note that using the
# `Log In` script will automatically unlock the session in addition
# to authenticating.
#
# Use this script only for unlocking an authenticated, but locked,
# session. You can check your session's authentication and lock status
# using the `Session Status` command.

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Unlock Session
# @raycast.mode silent
#
# Optional parameters:
# @raycast.packageName Bitwarden
# @raycast.icon images/bitwarden.png
# @raycast.argument1 { "type": "text", "placeholder": "Master Password", "secure": true }
#
# Documentation
# @raycast.author Phil Salant
# @raycast.authorURL https://github.com/PSalant726
# @raycast.description Unlock an authenticated Bitwarden session.

if ! command -v bw &> /dev/null; then
  echo "The Bitwarden CLI is not installed."
  exit 1
fi

out=$(bw --raw unlock "$1")
status=$?

if [ $status -eq 0 ]; then
  security add-generic-password -U -a ${USER} -s raycast-bitwarden -j "Bitwarden session token for use with Raycast" -w $out
  unset out
  echo "Session unlocked"
  exit 0
else
  echo $out
  exit 1
fi
