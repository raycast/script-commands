#!/bin/bash

# Dependency: This script requires `microlink` CLI installed: https://microlink.io/docs/api/getting-started/cli
# Install via npm: `npm install -g microlink`

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Microlink API
# @raycast.mode fullOutput

# Optional parameters:
# @raycast.icon https://cdn.microlink.io/logo/apple-touch-icon-60x60.png
# @raycast.argument1 { "type": "text", "placeholder": "url", "optional": false }

# Documentation:
# @raycast.description Microlink API integration
# @raycast.author Kiko Beats

microlink "$1"
