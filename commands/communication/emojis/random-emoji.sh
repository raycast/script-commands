#!/usr/bin/env bash

# Dependency: This script requires `jq` cli installed: https://stedolan.github.io/jq/
# Install via homebrew: `brew install jq`

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Random Emoji
# @raycast.mode silent
# @raycast.packageName Emojis

# Optional parameters:
# @raycast.icon 🎲

# Documentation:
# @raycast.description Copy a random emoji to the clipboard.
# @raycast.author Tomohiro Nishimura
# @raycast.authorURL https://github.com/Sixeight

LANG="en_US.UTF-8"

if ! command -v jq &> /dev/null; then
      echo "jq command is required (https://github.com/jqlang/jq).";
      exit 1;
fi

IFS=$'\n' read -d '' -r -a EMOJIS < <(curl -s https://raw.githubusercontent.com/github/gemoji/master/db/emoji.json | jq -r '.[] | .emoji' && printf '\0')
EMOJI="${EMOJIS[$RANDOM % ${#EMOJIS[@]}]}"
echo -n "$EMOJI" | pbcopy
echo "$EMOJI"
