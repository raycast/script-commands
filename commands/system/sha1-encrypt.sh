#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title SHA1 Encrypt
# @raycast.mode fullOutput
# @raycast.packageName System
#
# Optional parameters:
# @raycast.icon 🔐
# @raycast.needsConfirmation false
# @raycast.argument1 { "type": "text", "placeholder": "text", "optional": false }
#
# Documentation:
# @raycast.description Encrypt any text data by using SHA1 
# @raycast.author Bin Hua
# @raycast.authorURL https://github.com/hzb


echo -n $1 | sha1sum | tr -d '-' | pbcopy
echo "Copied to clipboard"