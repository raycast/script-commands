#!/bin/bash

# Note: NotePlan3 required
# Install via Mac App Store: https://apps.apple.com/app/noteplan-3/id1505432629

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Search NotePlan
# @raycast.mode silent

# Optional parameters:
# @raycast.icon images/noteplan.ico
# @raycast.argument1 { "type": "text", "placeholder": "Query", "percentEncoded": true }
# @raycast.packageName NotePlan3

# Documentation: Search NotePlan.
# @raycast.description Search NotePlan
# @raycast.author Göran Damberg
# @raycast.authorURL https://github.com/gdamberg

open "noteplan://x-callback-url/search?text=${1}"