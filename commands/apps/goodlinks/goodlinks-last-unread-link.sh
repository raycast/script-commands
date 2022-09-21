#!/bin/bash

# Install GoodLinks via Mac App Store: https://apps.apple.com/app/id1474335294

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Open Last Unread Link
# @raycast.mode silent

# Optional parameters:
# @raycast.icon images/goodlinks.png
# @raycast.packageName GoodLinks

# Documentation:
# @raycast.description Open the last unread link in the GoodLinks app
# @raycast.author Filip Chabik
# @raycast.authorURL https://github.com/hadret

open "goodlinks://x-callback-url/last"