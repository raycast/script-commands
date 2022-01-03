#!/bin/bash -l

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

if ! command -v microlink &> /dev/null
then
  echo "First run \`npm install -g microlink\`"
  exit
else
  microlink "$1"
fi

