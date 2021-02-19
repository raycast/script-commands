#!/bin/bash

# Dependency: This script requires `whois` CLI which is already installed on macOS.
# But if for some reason you don't have: brew install whois

# @raycast.title Whois
# @raycast.author Caleb Stauffer
# @raycast.authorURL https://github.com/crstauf
# @raycast.author Ronan Rodrigo Nunes
# @raycast.authorURL https://ronanrodrigo.dev

# @raycast.description Whois of URL.

# @raycast.icon 🌐
# @raycast.mode fullOutput
# @raycast.packageName Internet
# @raycast.schemaVersion 1

# @raycast.argument1 { "type": "text", "placeholder": "URL" }

if command -v whois &> /dev/null; then
    whois $1
else
    open https://who.is/whois/$1
fi
