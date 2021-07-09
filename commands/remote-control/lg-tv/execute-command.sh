#!/usr/bin/env bash

# Dependencies:
# LGWebOSRemote: https://github.com/klattimer/LGWebOSRemote

# Recommended installation: 
# Use pipx (https://github.com/pypa/pipx) to install the package system-wide:
# pipx install git+https://github.com/klattimer/LGWebOSRemote

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Execute Command
# @raycast.mode fullOutput

# Optional parameters:
# @raycast.packageName LG TV
# @raycast.icon images/lg.png
# @raycast.argument1 { "type": "text", "placeholder": "Command" }
# @raycast.argument2 { "type": "text", "placeholder": "Arguments" }

# Documentation:
# @raycast.author Jakub Lanski
# @raycast.authorURL https://github.com/jaklan
# @raycast.description Execute the given command on TV.

# Modified PATH to include pipx-installed packages. If you used a different installation method, adjust the variable properly to make the 'lgtv' package detectable.
PATH="$HOME/.local/bin:$PATH"

lgtv tv execute $1 $2
