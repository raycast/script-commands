#!/bin/bash

# Dependency: requires the google-docs-to-markdown npm package: https://github.com/Mr0grog/google-docs-to-markdown

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Convert Google Docs Rich Text HTML to Markdown
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 📋
# @raycast.packageName Conversions
# @raycast.description A script to take the HTML pastboard type filled by google docs and convert it to nicely formatted markdown

# Documentation:
# @raycast.author Michael Bianco
# @raycast.authorURL https://github.com/iloveitaly

set -euo pipefail

swift - <<EOF | npx google-docs-to-markdown | pbcopy
import Cocoa

let type = NSPasteboard.PasteboardType.html

guard let string = NSPasteboard.general.string(forType:type) else {
  fputs("Could not find string data of type '\(type)' on the system pasteboard\n", stderr)
  exit(1)
}

print(string)
EOF

