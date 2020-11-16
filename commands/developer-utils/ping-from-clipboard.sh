#!/bin/bash

# @raycast.schemaVersion 1
# @raycast.title Ping Address in Clipboard
# @raycast.mode fullOutput
# @raycast.author Caleb Stauffer
# @raycast.authorURL https://github.com/crstauf
# @raycast.description Ping an IP address or URL in clipboard.
# @raycast.packageName Internet
# @raycast.needsConfirmation true
# @raycast.icon 🌐

clipboard=$(pbpaste)
ping -i 0.25 -t 3 "$clipboard"