#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.icon images/devutils.png
# @raycast.title URL Encode/Decode
# @raycast.mode silent
# @raycast.packageName DevUtils.app

# Documentation:
# @raycast.description Decode the current URL string in your clipboard (if any)
# @raycast.author DevUtils.app
# @raycast.authorURL https://devutils.app

open devutils://urlencode?clipboard
