#!/bin/bash

# Required parameters:
# @raycast.author Jax0rz
# @authorURL https://github.com/Jax0rz
# @raycast.schemaVersion 1
# @raycast.title Search in Taobao
# @raycast.mode silent
# @raycast.packageName Web Searches

# Optional parameters:
# @raycast.icon images/taobao.png
# @raycast.argument1 { "type": "text", "placeholder": "Placeholder", "percentEncoded": true }

open "https://s.taobao.com/search?q=$1"