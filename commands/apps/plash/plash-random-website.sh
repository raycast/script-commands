#!/bin/bash

# Note: Plash v2.3.0 required
# Install via Mac App Store: https://apps.apple.com/app/id1494023538

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Switch to Random Website
# @raycast.mode silent

# Optional parameters:
# @raycast.icon ./images/plash.png
# @raycast.packageName Plash

# Documentation:
# @raycast.author Plash
# @raycast.authorURL https://github.com/sindresorhus/Plash
# @raycast.description Switch to a random website from the list of websites in Plash.

open --background plash:random
