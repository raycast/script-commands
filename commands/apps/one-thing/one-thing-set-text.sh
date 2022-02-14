#!/bin/bash

# Note: One Thing v1.2.1 required
# Install via Mac App Store: https://apps.apple.com/app/id1604176982

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Set Text
# @raycast.mode silent

# Optional parameters:
# @raycast.icon ./images/one-thing.png
# @raycast.packageName One Thing

# Documentation:
# @raycast.author One Thing
# @raycast.authorURL https://sindresorhus.com/one-thing
# @raycast.description Set the text shown in One Thing app.
# @raycast.argument1 { "type": "text", "placeholder": "text", "percentEncoded": true }

open --background "one-thing:?text=$1"
