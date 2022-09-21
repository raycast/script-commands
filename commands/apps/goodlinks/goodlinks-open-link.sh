#!/bin/bash

# Install GoodLinks via Mac App Store: https://apps.apple.com/app/id1474335294

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Open Link
# @raycast.mode silent

# Optional parameters:
# @raycast.icon images/goodlinks.png
# @raycast.packageName GoodLinks

# Documentation:
# @raycast.description Open a link in the GoodLinks app
# @raycast.author Filip Chabik
# @raycast.authorURL https://github.com/hadret

# @raycast.argument1 { "type": "text", "placeholder": "URL", "percentEncoded": true}

open "goodlinks://x-callback-url/open?url=${1}"