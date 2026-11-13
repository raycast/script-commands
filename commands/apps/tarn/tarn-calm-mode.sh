#!/bin/bash

# Note: Tarn required
# Install: https://github.com/jakeantelis/Tarn#install

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Start Calm Mode
# @raycast.mode silent

# Optional parameters:
# @raycast.icon ./images/tarn.png
# @raycast.packageName Tarn

# Documentation:
# @raycast.author Jake Antelis
# @raycast.authorURL https://github.com/jakeantelis
# @raycast.description Start Calm mode in Tarn.

CLI="$(command -v tarnctl)"
if [ -z "$CLI" ]; then
  APP="$(mdfind "kMDItemCFBundleIdentifier == 'com.antelislabs.tarn'" 2>/dev/null | head -1)"
  for dir in "/Applications/Tarn.app" "$HOME/Applications/Tarn.app" "$APP"; do
    if [ -n "$dir" ] && [ -x "$dir/Contents/Resources/tarnctl" ]; then
      CLI="$dir/Contents/Resources/tarnctl"
      break
    fi
  done
fi
if [ -z "$CLI" ]; then
  echo "Tarn is not installed"
  exit 1
fi

"$CLI" calm
