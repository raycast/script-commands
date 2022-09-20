#!/bin/bash

# Install GoodLinks via Mac App Store: https://apps.apple.com/app/id1474335294

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Save Link
# @raycast.mode silent

# Optional parameters:
# @raycast.icon images/goodlinks.png
# @raycast.packageName GoodLinks

# Documentation:
# @raycast.description Saves a new link to GoodLinks
# @raycast.author Filip Chabik
# @raycast.authorURL https://github.com/hadret

# @raycast.argument1 { "type": "text", "placeholder": "URL", "percentEncoded": true}
# @raycast.argument2 { "type": "text", "placeholder": "Tags", "optional": true, "percentEncoded": true}
# @raycast.argument3 { "type": "text", "placeholder": "Title", "optional": true, "percentEncoded": true}

open "goodlinks://x-callback-url/save?url=${1}&tags=${2}&title=${3}&quick=1"

echo "Link saved!"