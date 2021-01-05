#!/bin/bash

# Required parameters:
# @raycast.author Jax0rz
# @authorURL https://github.com/Jax0rz
# @raycast.schemaVersion 1
# @raycast.title Search in Devdocs
# @raycast.mode silent
# @raycast.packageName Navigation

# Optional parameters:
# @raycast.icon images/devdocs.png
# @raycast.argument1 { "type": "text", "placeholder": "doc", "percentEncoded": true}
# @raycast.argument2 { "type": "text", "placeholder": "term", "percentEncoded": true}

open "devdocs-macos://search?doc=$1&term=$2"