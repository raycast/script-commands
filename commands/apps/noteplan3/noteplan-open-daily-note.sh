#!/bin/bash

# Note: NotePlan3 required
# Install via Mac App Store: https://apps.apple.com/app/noteplan-3/id1505432629

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Open Daily Note
# @raycast.mode silent

# Optional parameters:
# @raycast.icon images/noteplan.ico
# @raycast.packageName NotePlan3

# Documentation: Opens todays daily note in NotePlan
# @raycast.description Open todays daily note
# @raycast.author Göran Damberg
# @raycast.authorURL https://github.com/gdamberg

open "noteplan://x-callback-url/openNote?noteDate=today"