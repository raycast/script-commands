#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Open URL From Clipboard
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🌐

open $(pbpaste)
