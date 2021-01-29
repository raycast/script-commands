#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Search in Kinopoisk
# @raycast.mode silent
# @raycast.packageName Web Searches

# Optional parameters:
# @raycast.icon images/kinopoisk.png
# @raycast.argument1 { "type": "text", "placeholder": "query", "percentEncoded": true }

open "https://www.kinopoisk.ru/index.php?kp_query=$1"
