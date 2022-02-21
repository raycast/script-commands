#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.icon images/devutils.png
# @raycast.title SQL Formatter
# @raycast.mode silent
# @raycast.packageName DevUtils.app

# Documentation:
# @raycast.description Format the SQL string currently in your clipboard
# @raycast.author DevUtils.app
# @raycast.authorURL https://devutils.app

open devutils://sqlformatter?clipboard
