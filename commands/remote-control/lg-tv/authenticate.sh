#!/usr/bin/env bash

# Dependencies:
# LGWebOSRemote: https://github.com/klattimer/LGWebOSRemote

# Recommended installation: 
# Use pipx (https://github.com/pypa/pipx) to install the package system-wide:
# pipx install git+https://github.com/klattimer/LGWebOSRemote

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Authenticate
# @raycast.mode silent

# Optional parameters:
# @raycast.packageName LG TV
# @raycast.icon images/lg.png
# @raycast.argument1 { "type": "text", "placeholder": "TV IP Address" }

# Documentation:
# @raycast.author Jakub Lanski
# @raycast.authorURL https://github.com/jaklan
# @raycast.description Authenticate the library. The TV has to be turned on. You have to provide the IP address of the TV and accept the connection on the TV.

# Modified PATH to include pipx-installed packages. If you used a different installation method, adjust the variable properly to make the 'lgtv' package detectable.
PATH="$HOME/.local/bin:$PATH"

lgtv auth $1 tv
