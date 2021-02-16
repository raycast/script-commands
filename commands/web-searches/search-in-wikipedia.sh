#!/bin/bash

# Required parameters:
# @raycast.author Jax0rz
# @authorURL https://github.com/Jax0rz
# @raycast.schemaVersion 1
# @raycast.title Search in Wikipedia
# @raycast.mode silent
# @raycast.packageName Web Searches

# Optional parameters:
# @raycast.icon images/wikipedia.png
# @raycast.argument1 { "type": "text", "placeholder": "Search term...", "percentEncoded": true }

domain="zh"

open "https://$domain.wikipedia.org/w/index.php?search=$1"
