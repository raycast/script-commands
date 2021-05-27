#!/bin/bash

# Note: Plash v2.2.0 required

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Reload
# @raycast.mode silent

# Optional parameters:
# @raycast.icon ./images/plash.png
# @raycast.packageName Plash

# Documentation:
# @raycast.author Plash
# @raycast.authorURL https://github.com/sindresorhus/Plash
# @raycast.description Reload the current website in Plash.

open --background plash:reload
