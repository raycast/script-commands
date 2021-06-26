#!/bin/bash

# Note: Agenda required
# Install via Mac App Store: https://apps.apple.com/us/app/agenda/id1287445660

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Agenda Today Overview
# @raycast.mode silent

# Optional parameters:
# @raycast.icon images/agenda.png
# @raycast.packageName Agenda

# Documentation:
# @raycast.description Opens Agenda - Today Overview
# @raycast.author Michael Ellis
# @raycast.authorURL https://github.com/mtellis2


open "agenda://x-callback-url/today"

echo "Opened Today's Notes."