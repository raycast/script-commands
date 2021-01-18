#!/bin/bash

# @raycast.title Whois
# @raycast.author Caleb Stauffer
# @raycast.authorURL https://github.com/crstauf
# @raycast.description Whois of URL.

# @raycast.icon 🌐
# @raycast.mode fullOutput
# @raycast.packageName Internet
# @raycast.schemaVersion 1

# @raycast.argument1 { "type": "text", "placeholder": "URL" }

if type "whois" &> /dev/null; then
    whois $1
else
    open https://who.is/whois/$1
fi
