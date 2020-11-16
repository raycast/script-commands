#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Prettify JSON
# @raycast.mode fullOutput

# Optional parameters:
# @raycast.icon 💻

pbpaste | python -m json.tool