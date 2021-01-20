#!/bin/bash

# Dependency: This script requires `dig` to be installed and in $PATH
#
# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Dig
# @raycast.mode fullOutput
#
# Optional parameters:
# @raycast.icon 🌍
# @raycast.packageName Internet
# @raycast.argument1 { "type": "text", "placeholder": "name" }
# @raycast.argument2 { "type": "text", "placeholder": "type", "optional": true }
#
# @raycast.description Perform a dig command with the specified options
# @raycast.author Tommaso Panozzo
# @raycase.authorURL https://github.com/tom139

dig $1 $2
