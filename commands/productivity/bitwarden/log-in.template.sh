#!/bin/bash

# Dependency: This script requires the Bitwarden CLI:
# https://bitwarden.com/help/article/cli/
#
# Install via homebrew: `brew install bitwarden-cli`

# If logging in with multi-factor authentication, set the `MFA_METHOD`
# as necessary. Otherwise, leave this variable set to the empty string.
#
# Authenticator: 0
# Email: 1
# Yubikey: 3
MFA_METHOD=""

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Log In
# @raycast.mode silent
#
# Optional parameters:
# @raycast.packageName Bitwarden
# @raycast.icon images/bitwarden.png
# @raycast.argument1 { "type": "text", "placeholder": "Email" }
# @raycast.argument2 { "type": "text", "placeholder": "Master Password", "secure": true }
# @raycast.argument3 { "type": "text", "placeholder": "MFA Code", "optional": true }
#
# Documentation
# @raycast.author Phil Salant
# @raycast.authorURL https://github.com/PSalant726
# @raycast.description Log in to Bitwarden.

if ! command -v bw &> /dev/null; then
  echo "The Bitwarden CLI is not installed."
  exit 1
fi

if [ -n "$MFA_METHOD" ]; then
  mfa="--method $MFA_METHOD --code $3"
fi

out=$(bw --raw login $1 $2 $mfa)
status=$?

if [ $status -eq 0 ]; then
  security add-generic-password -U -a ${USER} -s raycast-bitwarden -j "Bitwarden session token for use with Raycast" -w $out
  unset out
  echo "Login successful! Your session is now unlocked."
  exit 0
else
  echo $out
  exit 1
fi
