#!/bin/bash

# What does this do?
# Search Invidious with the parameter
# Invidious is an alternative front-end to YouTube
# Find out more at: https://github.com/iv-org/invidious

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Search Invidious
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 📹
# @raycast.argument1 { "type": "text", "placeholder": "keyword", "percentEncoded": true}
# @raycast.packageName Alt-YouTube Frontend

# Documentation:
# @raycast.description Takes a keyword and searches the set invidious instance
# @raycast.author Deepankar Chakroborty
# @raycast.authorURL https://dchakro.com

# Set your favorite invidious instance:
# Find more here: https://instances.invidious.io/
INVIDIOUS_INSTANCE='https://yewtu.be'

open "${INVIDIOUS_INSTANCE}/search?q=${1}"


