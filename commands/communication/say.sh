#!/bin/bash

# @raycast.title Say
# @raycast.author Felipe Turcheti
# @raycast.authorURL https://felipeturcheti.com
# @raycast.description Convert text to audible speech.

# @raycast.icon 🗣
# @raycast.mode silent
# @raycast.packageName Communication
# @raycast.schemaVersion 1

# @raycast.argument1 { "type": "text", "placeholder": "Say this...", "optional": false }

say "$1"
