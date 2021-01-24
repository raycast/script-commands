#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Strong Password Generator
# @raycast.mode compact
# @raycast.packageName Developer Utils

# Optional parameters:
# @raycast.icon 🔐
# @raycast.argument1 { "type": "text", "placeholder": "Length"}

# Documentation:
# @raycast.author Nitin Gupta
# @raycast.authorURL https://twitter.com/gniting
# @raycast.description Generate a strong password of requested character length

openssl rand -base64 $1 | head -c$1 | pbcopy; echo -n `pbpaste`
