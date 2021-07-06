#!/bin/bash

# @raycast.title URL IPv6
# @raycast.author Caleb Stauffer
# @raycast.authorURL https://github.com/crstauf
# @raycast.description Get IPv6 address of URL.

# @raycast.icon 🌐
# @raycast.mode compact
# @raycast.packageName Internet
# @raycast.schemaVersion 1

# @raycast.argument1 { "type": "text", "placeholder": "URL" }

ip=$(dig -6 +short +time=1 $1 | awk '{ print ; exit }')
echo $ip | pbcopy
echo "Copied $ip"
