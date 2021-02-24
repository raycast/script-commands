#!/bin/bash

# Required parameters:
# @raycast.author Jax0rz
# @authorURL https://github.com/Jax0rz
# @raycast.schemaVersion 1
# @raycast.title Search in Bear
# @raycast.mode silent
# @raycast.packageName Navigation

# Optional parameters:
# @raycast.icon images/bear.png
# @raycast.argument1 { "type": "text", "placeholder": "query", "percentEncoded": true}

open "bear://x-callback-url/search?term=$1&show_window=yes"