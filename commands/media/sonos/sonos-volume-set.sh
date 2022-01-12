#!/bin/bash

# Dependency: This script requires `soco` cli installed: https://github.com/avantrec/soco-cli
# Install via pip: `pip install soco-cli`

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Set Volume
# @raycast.mode silent
# @raycast.packageName Sonos

# Optional parameters:
# @raycast.icon images/sonos-logo.png

# Documentation:
# @raycast.description Sets volume of Sonos.
# @raycast.author David Blackman
# @raycast.authorURL https://github.com/whizziwig

# @raycast.argument1 { "type": "text", "placeholder": "Level" }

if ! command -v soco &> /dev/null; then
      echo "soco command is required (https://github.com/avantrec/soco-cli).";
      exit 1;
fi

soco _all_ volume $1