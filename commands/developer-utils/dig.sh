#!/bin/bash

# Raycast Script Command to perform a Dig Command
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
# @raycast.description "Perform a dig command with the specified options"

dig $1 $2

