#!/bin/bash

# Install GoodLinks via Mac App Store: https://apps.apple.com/app/id1474335294

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Show Tag
# @raycast.mode silent

# Optional parameters:
# @raycast.icon images/goodlinks.png
# @raycast.packageName GoodLinks

# Documentation:
# @raycast.description Show links tagged with the specified tag in the GoodLinks app
# @raycast.author Filip Chabik
# @raycast.authorURL https://github.com/hadret

# @raycast.argument1 { "type": "text", "placeholder": "name", "percentEncoded": true}

open "goodlinks://x-callback-url/tag?name=${1}"