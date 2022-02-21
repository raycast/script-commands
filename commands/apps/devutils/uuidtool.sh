#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.icon images/devutils.png
# @raycast.title UUID/ULID Generate/Decode
# @raycast.mode silent
# @raycast.packageName DevUtils.app

# Documentation:
# @raycast.description Decode the UUID in your clipboard (if any), or generate UUIDs
# @raycast.author DevUtils.app
# @raycast.authorURL https://devutils.app

open devutils://uuidtool?clipboard
