#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title URL IPv4
# @raycast.mode compact

# Optional parameters:
# @raycast.author Caleb Stauffer
# @raycast.authorURL https://github.com/crstauf
# @raycast.description Get IPv4 address of URL
# @raycast.packageName Internet
# @raycast.icon 🌐
# @raycast.argument1 { "type": "text", "placeholder": "URL" }

ip=$(dig -4 +short +time=1 $1 | awk '{ print ; exit }')
echo $ip | pbcopy
echo "Copied $ip"