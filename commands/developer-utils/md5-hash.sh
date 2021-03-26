#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title MD5 Hash
# @raycast.mode silent
# @raycast.packageName Developer Utilities
#
# Optional parameters:
# @raycast.icon 🔐
# @raycast.needsConfirmation false
# @raycast.argument1 { "type": "text", "placeholder": "text", "optional": false }
#
# Documentation:
# @raycast.description Hashing any text data by using MD5 
# @raycast.author Bin Hua
# @raycast.authorURL https://github.com/hzb


echo -n $1 | md5 -r | pbcopy
echo "Copied to clipboard"