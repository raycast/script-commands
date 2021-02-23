#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Search in MDN (Mozilla) Docs by Topic
# @raycast.mode silent
#
# Optional parameters:
# @raycast.packageName Web Searches
# @raycast.icon images/mdn_light.png
# @raycast.iconDark images/mdn_dark.png
# @raycast.argument1 { "type": "text", "placeholder": "js, css, html", "optional": true, "percentEncoded": true }
# @raycast.argument2 { "type": "text", "placeholder": "query", "percentEncoded": true }
#
# Documentation:
# @raycast.author Jesse Traynham
# @raycast.authorURL https://github.com/traynham
# @raycast.description Search in MDN (Mozilla) Docs by topic

open "https://developer.mozilla.org/search?topic=${1}&q=${2}"
