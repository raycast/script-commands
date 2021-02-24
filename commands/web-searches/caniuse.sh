#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Caniuse.com search
# @raycast.mode silent
# @raycast.author Zander Martineau
# @raycast.authorURL https://zander.wtf

# Optional parameters:
# @raycast.icon ❓
# @raycast.packageName Web searches
# @raycast.argument1 { "type": "text", "placeholder": "feature", "percentEncoded": true }

open "https://caniuse.com/#search=${1}"
