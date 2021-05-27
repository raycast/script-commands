#!/bin/bash

# Dependency: This script requires `espanso` cli installed: https://espanso.org/install/

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Restart Espanso
# @raycast.mode silent

# Optional parameters:
# @raycast.icon images/espanso.png
# @raycast.packageName Espanso

# Documentation:
# @raycast.author es183923
# @raycast.authorURL https://github.com/es183923

if ! command -v espanso &> /dev/null; then
      echo "espanso is required (https://espanso.org/install).";
      exit 1;
fi

espanso restart
