#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Caniemail.com search
# @raycast.mode silent
# @raycast.author Vincent Taverna
# @raycast.authorURL https://vincenttaverna.com

# Optional parameters:
# @raycast.icon ❓
# @raycast.packageName Web searches
# @raycast.argument1 { "type": "text", "placeholder": "feature", "percentEncoded": true }

open "https://www.caniemail.com/search/?s=${1}"
