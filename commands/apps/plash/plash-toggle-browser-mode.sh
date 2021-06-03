#!/bin/bash

# Note: Plash v2.2.0 required
# Install via Mac App Store: https://apps.apple.com/app/id1494023538

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Toggle Browsing Mode
# @raycast.mode silent

# Optional parameters:
# @raycast.icon ./images/plash.png
# @raycast.packageName Plash

# Documentation:
# @raycast.author Plash
# @raycast.authorURL https://github.com/sindresorhus/Plash
# @raycast.description Toggle browsing mode in Plash.

open --background plash:toggle-browsing-mode
