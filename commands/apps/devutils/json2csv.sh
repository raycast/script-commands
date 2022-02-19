#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.icon images/devutils.png
# @raycast.title JSON to CSV
# @raycast.mode silent
# @raycast.packageName DevUtils.app

# Documentation:
# @raycast.description Convert your current clipboard from JSON to CSV
# @raycast.author DevUtils.app
# @raycast.authorURL https://devutils.app

open devutils://json2csv?clipboard
