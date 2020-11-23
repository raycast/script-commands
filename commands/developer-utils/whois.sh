#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Whois
# @raycast.mode silent

# Optional parameters:
# @raycast.author Caleb Stauffer
# @raycast.authorURL https://github.com/crstauf
# @raycast.description Whois of URL.
# @raycast.packageName Internet
# @raycast.icon 🌐
# @raycast.argument1 { "type": "text", "placeholder": "URL" }

open https://who.is/whois/$1