#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title SHA1 Hash
# @raycast.mode silent
# @raycast.packageName Developer Utilities
#
# Optional parameters:
# @raycast.icon 🔐
# @raycast.needsConfirmation false
# @raycast.argument1 { "type": "text", "placeholder": "text", "optional": false }
#
# Documentation:
# @raycast.description Hashing any text data by using SHA1 
# @raycast.author Bin Hua
# @raycast.authorURL https://github.com/hzb


echo -n $1 | shasum | tr -d '-' | pbcopy
echo "Copied to clipboard"