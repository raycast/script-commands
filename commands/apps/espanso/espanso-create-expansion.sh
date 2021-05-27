#!/bin/bash

# Dependency: This script requires `espanso` cli installed: https://espanso.org/install/

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Create Text Expansion
# @raycast.mode silent

# Optional parameters:
# @raycast.icon images/espanso.png
# @raycast.packageName Espanso
# @raycast.argument1 { "type": "text", "placeholder": ":shortcut", "optional": false }
# @raycast.argument2 { "type": "text", "placeholder": "Text", "optional": false }

# Documentation:
# @raycast.description Add a text expansion to expanso
# @raycast.author Max Stoiber
# @raycast.authorURL https://github.com/mxstbr

if ! command -v espanso &> /dev/null; then
      echo "espanso is required (https://espanso.org/install).";
      exit 1;
fi

echo "  - trigger: \"$1\"
    replace: \"$2\"" >> ~/Library/Preferences/espanso/default.yml

espanso restart
