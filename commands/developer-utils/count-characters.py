#!/usr/bin/env python3

# Dependency: This script requires the python `pasteboard` library: https://github.com/tobywf/pasteboard
# Install via pip: `pip install pasteboard`

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Count characters
# @raycast.mode compact

# Optional parameters:
# @raycast.icon 🤖
# @raycast.argument1 { "type": "text", "placeholder": "Text", "optional": true }
# @raycast.packageName Developer Utils

# Documentation:
# @raycast.description Counts the characters of either the clipboard or the passed argument
# @raycast.author Sven Bendel
# @raycast.authorURL https://github.com/ubuntudroid

import sys
import pasteboard

arg = sys.argv[1]

if not arg:
    pb = pasteboard.Pasteboard()
    text = pb.get_contents()
else:
    text = arg

print(str(len(text)) + " chars")
