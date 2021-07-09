#!/usr/bin/env bash

# Dependencies:
# LGWebOSRemote: https://github.com/klattimer/LGWebOSRemote

# Recommended installation: 
# Use pipx (https://github.com/pypa/pipx) to install the package system-wide:
# pipx install git+https://github.com/klattimer/LGWebOSRemote

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Close App
# @raycast.mode silent

# Optional parameters:
# @raycast.packageName LG TV
# @raycast.icon images/lg.png
# @raycast.argument1 { "type": "text", "placeholder": "App ID" }

# Documentation:
# @raycast.author Jakub Lanski
# @raycast.authorURL https://github.com/jaklan
# @raycast.description Close the application by its ID.

# Modified PATH to include pipx-installed packages. If you used a different installation method, adjust the variable properly to make the 'lgtv' package detectable.
PATH="$HOME/.local/bin:$PATH"

lgtv tv closeApp $1
