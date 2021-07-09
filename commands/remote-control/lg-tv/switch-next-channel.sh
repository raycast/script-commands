#!/usr/bin/env bash

# Dependencies:
# LGWebOSRemote: https://github.com/klattimer/LGWebOSRemote

# Recommended installation: 
# Use pipx (https://github.com/pypa/pipx) to install the package system-wide:
# pipx install git+https://github.com/klattimer/LGWebOSRemote

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Switch To Next Channel
# @raycast.mode silent

# Optional parameters:
# @raycast.packageName LG TV
# @raycast.icon images/lg.png

# Documentation:
# @raycast.author Jakub Lanski
# @raycast.authorURL https://github.com/jaklan
# @raycast.description Switch to the next TV channel.

# Modified PATH to include pipx-installed packages. If you used a different installation method, adjust the variable properly to make the 'lgtv' package detectable.
PATH="$HOME/.local/bin:$PATH"

lgtv tv inputChannelUp
