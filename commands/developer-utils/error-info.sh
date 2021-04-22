#!/bin/bash

# Dependency: requires mint and errorinfo
# Instal via mint Homebrew and errorinfo via Mint: `brew install mint && mint install errorinfo`

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Error Info
# @raycast.mode fullOutput
# @raycast.packageName Developer Utilities

# Optional parameters:
# @raycast.icon ℹ️
# @raycast.argument1 { "type": "text", "placeholder": "Error term" }

# Documentation:
# @raycast.description Get info about Apple API errors
# @raycast.author Ronan Rodrigo Nunes
# @raycast.authorURL https://ronanrodrigo.dev

errorinfo $1
