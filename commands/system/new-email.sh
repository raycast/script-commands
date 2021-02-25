#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Create Email
# @raycast.mode silent
# @raycast.author Brandon Escamilla
# @raycast.authorURL https://github.com/brandonescamilla
# Optional parameters:
# @raycast.icon 📧
# @raycast.packageName System
# @raycast.argument1 { "type": "text", "placeholder": "To", "optional": true, "percentEncoded": true }
# @raycast.argument2 { "type": "text", "placeholder": "Subject", "optional": true, "percentEncoded": true }
# @raycast.argument3 { "type": "text", "placeholder": "Body", "optional": true, "percentEncoded": true }

# Documentation:
# @raycast.description Opens default email application, and creates a new email with the given inputs.


open "mailto:${1}?subject=${2}&body=${3}"
