#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Whois of clipboard URL
# @raycast.mode silent
# @raycast.packageName Internet

# Optional parameters:
# @raycast.author Caleb Stauffer
# @raycast.authorURL https://github.com/crstauf
# @raycast.description Whois of clipboard URL.
# @raycast.needsConfirmation true
# @raycast.icon 🌐

clipboard=$(pbpaste)

open https://who.is/whois/$clipboard