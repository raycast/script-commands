#!/bin/bash

# Note: Obsidian v0.8.15+ required
# Install via: 1) https://obsidian.md 2) brew install --cask obsidian

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Create Note
# @raycast.mode silent

# Optional parameters:
# @raycast.icon ./images/obsidian.png
# @raycast.argument1 { "type": "text", "placeholder": "Name", "optional": false, "percentEncoded": true}
# @raycast.argument2 { "type": "text", "placeholder": "Content", "optional": true, "percentEncoded": true}
# @raycast.packageName Obsidian

# Documentation:
# @raycast.description Create a new note
# @raycast.author Yiyao Wei
# @raycast.authorURL https://github.com/HotThoughts

# The name of your vault, e.g., "Knowledge Base"
VAULT_NAME=""

if [ -z "$VAULT_NAME" ]
then
  echo "Configure VAULT_NAME"
  exit 1
fi

open "obsidian://new?vault=$VAULT_NAME&name=${1}&content=${2}"
