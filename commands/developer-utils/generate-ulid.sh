#!/bin/bash

# Dependency: This script requires `ulid` installed: https://github.com/ulid/javascript
# Install via npm: `npm install -g ulid`

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Generate ULID
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 💻
# @raycast.packageName Developer Utilities

# Documentation:
# @raycast.description Generates a ULID and copies it to the clipboard.
# @raycast.author David Molinero
# @raycast.authorURL https://github.com/doktor500

NODE_PATH=$(which node | xargs readlink | xargs dirname);

export PATH="$PATH:${NODE_PATH}";

if ! ulid &> /dev/null; then
  echo "ulid is required (https://github.com/ulid/javascript)";
  exit 1;
fi

id=$(ulid);
echo "$id" | pbcopy;
echo "$id";
