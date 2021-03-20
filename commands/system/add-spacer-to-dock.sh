#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Add Spacer to Dock
# @raycast.mode compact

# Optional parameters:
# @raycast.icon 💻

# @Documentation:
# @raycast.packageName System
# @raycast.description Adds an invisible icon to the Dock as a separator.
# @raycast.author Alexandru Turcanu
# @raycast.authorURL https://github.com/Pondorasti

defaults write com.apple.dock persistent-apps -array-add '{"tile-type"="spacer-tile";}'
killall Dock
echo "Added spacer to dock"
