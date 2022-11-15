#!/bin/bash

# Required parameters:
# @raycast.author emircanerkul
# @authorURL https://github.com/emircanerkul
# @raycast.schemaVersion 1
# @raycast.title Search in Drupal
# @raycast.mode silent
# @raycast.packageName Web Searches

# Optional parameters:
# @raycast.icon images/drupal.png
# @raycast.argument1 { "type": "text", "placeholder": "query", "percentEncoded": true }

open "https://www.drupal.org/search/site/$1"