#!/bin/bash

# Note: Plash v2.2.0 required

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Add
# @raycast.mode silent

# Optional parameters:
# @raycast.icon ./images/plash.png
# @raycast.packageName Plash

# Documentation:
# @raycast.author Plash
# @raycast.authorURL https://github.com/sindresorhus/Plash
# @raycast.description Add a website to Plash.
# @raycast.argument1 { "type": "text", "placeholder": "url", "percentEncoded": true }
# @raycast.argument2 { "type": "text", "placeholder": "title", "optional": true, "percentEncoded": true }

open --background "plash:add?url=$1&title=$2"
