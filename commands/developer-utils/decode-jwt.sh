#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Decode JWT
# @raycast.mode fullOutput
# @raycast.packageName Developer Utilities

# Optional parameters:
# @raycast.icon images/jwt-logo.png

# Documentation:
# @raycast.description Decodes JSON web token from the clipboard.

# JWT function from: 
# https://www.jvt.me/posts/2019/06/13/pretty-printing-jwt-openssl/
function jwt() {
  for part in 1 2; do
    b64="$(cut -f$part -d. <<< "$1" | tr '_-' '/+')"
    len=${#b64}
    n=$((len % 4))
    if [[ 2 -eq n ]]; then
      b64="${b64}=="
    elif [[ 3 -eq n ]]; then
      b64="${b64}="
    fi
    d="$(openssl enc -base64 -d -A <<< "$b64")"
    python -mjson.tool <<< "$d"
    # don't decode further if this is an encrypted JWT (JWE)
    if [[ 1 -eq part ]] && grep '"enc":' <<< "$d" >/dev/null ; then
        exit 0
    fi
  done
}

jwt $(pbpaste)