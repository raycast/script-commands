#!/bin/bash

# Dependency: This script requires `soco` cli installed: https://github.com/avantrec/soco-cli
# Install via pip: `pip install soco-cli`

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Play Favorite
# @raycast.mode silent
# @raycast.packageName Sonos

# Optional parameters:
# @raycast.icon images/sonos-logo.png

# Documentation:
# @raycast.description Play from Sonos favorites.
# @raycast.author David Blackman
# @raycast.authorURL https://github.com/whizziwig

# @raycast.argument1 { "type": "text", "placeholder": "Favorite Search" }

if ! command -v soco &> /dev/null; then
      echo "soco command is required (https://github.com/avantrec/soco-cli).";
      exit 1;
fi

soco _all_ play_fav "$1"