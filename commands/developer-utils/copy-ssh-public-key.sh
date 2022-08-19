#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Copy SSH Public Key
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🔑
# @raycast.packageName Developer Utils

# Documentation:
# @raycast.description Copying the default SSH public key to the clipboard
# @raycast.author Angelos Michalopoulos
# @raycast.authorURL https://github.com/miagg

if [ -f "$HOME/.ssh/id_rsa.pub" ]; then
  pbcopy < "$HOME/.ssh/id_rsa.pub"
elif [ -f "$HOME/.ssh/id_dsa.pub" ]; then
  pbcopy < "$HOME/.ssh/id_dsa.pub"
elif [ -f "$HOME/.ssh/id_ed25519.pub" ]; then
  pbcopy < "$HOME/.ssh/id_ed25519.pub"
else
  echo "No SSH public key was found"
  exit 1
fi

echo "SSH public key was copied to the clipboard"

