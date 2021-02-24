#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Search MDN (Mozilla Developer Network)
# @raycast.mode silent
# @raycast.packageName Web Searches
# @raycast.author Jon Callahan
# @raycast.authorURL https://www.joncallahan.com

# Optional parameters:
# @raycast.icon images/mozilla-developer-network.png
# @raycast.argument1 { "type": "text", "placeholder": "query", "percentEncoded": true }

open "https://developer.mozilla.org/search?q=${1}"
