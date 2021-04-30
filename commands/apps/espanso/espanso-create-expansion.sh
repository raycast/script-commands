#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Create text expansion
# @raycast.mode silent

# Optional parameters:
# @raycast.argument1 { "type": "text", "placeholder": ":shortcut", "optional": false }
# @raycast.argument2 { "type": "text", "placeholder": "Text", "optional": false }

# Documentation:
# @raycast.description Add a text expansion to expanso
# @raycast.author Max Stoiber
# @raycast.authorURL https://github.com/mxstbr

echo "  - trigger: \"$1\"
    replace: \"$2\"" >> ~/Library/Preferences/espanso/default.yml

espanso restart
