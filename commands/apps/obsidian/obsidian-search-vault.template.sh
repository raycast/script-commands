#!/bin/bash

# Note: Obsidian v0.8.15+ required
# Install via: 1) https://obsidian.md 2) brew install --cask obsidian

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Search in Vault
# @raycast.mode silent

# Optional parameters:
# @raycast.icon ./images/obsidian.png
# @raycast.argument1 { "type": "text", "placeholder": "Type to search in vault..." }
# @raycast.packageName Obsidian

# Documentation:
# @raycast.description Search Obsidian Vault
# @raycast.author Yiyao Wei
# @raycast.authorURL https://github.com/HotThoughts

# The name of your vault, e.g., "Knowledge Base"
VAULT_NAME=""

if [ -z "$VAULT_NAME" ]
then
  echo "Configure VAULT_NAME"
  exit 1
fi

open "obsidian://search?vault=$VAULT_NAME&query=${1}"
