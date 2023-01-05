#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Get TTFB (Time to First Byte)
# @raycast.mode fullOutput

# Optional parameters:
# @raycast.icon 🕐
# @raycast.packageName Developer Utils

# Documentation:
# @raycast.description Get the TTFB (Time to First Byte) of a website
# @raycast.author Angelos Michalopoulos
# @raycast.authorURL https://github.com/miagg
# @raycast.argument1 { "type": "text", "placeholder": "URL" }

if [ -z "$1" ]; then
  echo "Please provide a domain"
  exit 1
fi

# If no url scheme is provided, add https://
if [[ "$1" == http* ]]; then
  url="$1"
else
  url="https://$1"
fi

echo "Pinging: $url..."

curl -o /dev/null \
    -H 'Cache-Control: no-cache' \
    -s \
    -w "\nLookup time:\t\t\t%{time_namelookup}\nConnect time:\t\t%{time_connect}\nSSL handshake time:\t%{time_appconnect}\nPre-Transfer time:\t%{time_pretransfer}\nRedirect time:\t\t%{time_redirect}\nTime to first byte:\t%{time_starttransfer}\n\nTotal time:\t\t\t%{time_total}\n" \
    --fail \
    --silent \
    --show-error \
    "$url"
