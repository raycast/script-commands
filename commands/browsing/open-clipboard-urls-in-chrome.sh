#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Open URLs in Clipboard in Chrome
# @raycast.mode silent
# @raycast.packageName Browsing

# Optional parameters:
# @raycast.icon 🔗

# Documentation:
# @raycast.author Michael Bianco
# @raycast.authorURL https://github.com/iloveitaly
# @raycast.description Open URLs in Clipboard in Chrome

pbpaste | xargs -n 1 open -a "Google Chrome"