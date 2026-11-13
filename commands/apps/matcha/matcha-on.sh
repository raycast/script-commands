#!/bin/bash

# Note: Matcha required
# Install: https://github.com/jakeantelis/Matcha#install

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Keep Awake
# @raycast.mode silent

# Optional parameters:
# @raycast.icon ./images/matcha.png
# @raycast.packageName Matcha

# Documentation:
# @raycast.author Jake Antelis
# @raycast.authorURL https://github.com/jakeantelis
# @raycast.description Keep your Mac awake, optionally for a set duration such as 2h or 90m.
# @raycast.argument1 { "type": "text", "placeholder": "Duration (e.g. 2h, 90m)", "optional": true }

CLI="$(command -v matchactl)"
if [ -z "$CLI" ]; then
  APP="$(mdfind "kMDItemCFBundleIdentifier == 'com.matcha.app'" 2>/dev/null | head -1)"
  for dir in "/Applications/Matcha.app" "$HOME/Applications/Matcha.app" "$APP"; do
    if [ -n "$dir" ] && [ -x "$dir/Contents/Resources/matchactl" ]; then
      CLI="$dir/Contents/Resources/matchactl"
      break
    fi
  done
fi
if [ -z "$CLI" ]; then
  echo "Matcha is not installed"
  exit 1
fi

if [ -n "$1" ]; then
  "$CLI" on "$1"
else
  "$CLI" on
fi
