#!/bin/bash

# Dependencies:
#   1. The Bitwarden CLI: https://bitwarden.com/help/article/cli/
#   2. The `jq` utility: https://stedolan.github.io/jq/
#
# Install via homebrew: `brew install bitwarden-cli jq`

# IMPORTANT:
# This script only displays accurate session statuses when you have
# previously used the `Log In`, `Unlock`, `Lock`, and `Log Out`
# scripts within this package. If you're getting unexpected results
# or errors, try running the `Log Out` script, or:
#   bw logout && security delete-generic-password -a ${USER} -s raycast-bitwarden
# and logging in again using the `Log In` script.

# Parameters
# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Bitwarden Status
# @raycast.mode inline

# Conditional parameters:
# @raycast.refreshTime 5m

# Optional parameters:
# @raycast.packageName Bitwarden
# @raycast.icon images/bitwarden.png

# Documentation:
# @raycast.author Phil Salant
# @raycast.authorURL https://github.com/PSalant726
# @raycast.description Display the authentication and lock status of the user's Bitwarden session.

if ! command -v bw &> /dev/null; then
  echo "⚠️  The Bitwarden CLI is not installed"
  exit 1
elif ! command -v jq &> /dev/null; then
  echo "⚠️  The jq utility is not installed"
  exit 1
fi

token=$(security find-generic-password -a ${USER} -s raycast-bitwarden -w 2> /dev/null)
token_status=$?

delete_token() {
  if [ $token_status -eq 0 ]; then
    security delete-generic-password -a ${USER} -s raycast-bitwarden > /dev/null 2>&1
  fi

  unset token
}

session=""
if [ $token_status -eq 0 ]; then
  session="--session $token"
fi

case $(bw --raw status $session 2> /dev/null | jq --raw-output '.status') in
  unauthenticated)
    delete_token
    echo "❌  Logged out"
    exit 0
    ;;

  locked)
    delete_token
    echo "🔒  Locked"
    exit 0
    ;;

  unlocked)
    echo "✅  Unlocked"
    unset token
    exit 0
    ;;

  *)
    echo "⚠️  An error occurred. Please try again."
    unset token
    exit 1
    ;;
esac
