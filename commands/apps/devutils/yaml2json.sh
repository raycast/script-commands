#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.icon images/devutils.png
# @raycast.title YAML to JSON
# @raycast.mode silent
# @raycast.packageName DevUtils.app

# Documentation:
# @raycast.description Convert your current clipboard from YAML to JSON
# @raycast.author DevUtils.app
# @raycast.authorURL https://devutils.app

open devutils://yaml2json?clipboard
