#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title I'm Feeling Ducky
# @raycast.mode silent

# Optional parameters:
# @raycast.icon ./images/duck-duck-go.png
# @raycast.argument1 { "type": "text", "placeholder": "Query" }
# @raycast.packageName Web Searches

# Documentation:
# @raycast.description Open the first DuckDuckGo search result page for your query (also supports bang!)
# @raycast.author Achille Lacoin
# @raycast.authorURL https://github.com/pomdtr

# region-specific search e.g. 'us-en' for US (default);
# visit https://duckduckgo.com/params
REGION=us-en

if ! command -v tldr &>/dev/null; then
    echo "ddgr is not installed."
    echo "Installation instructions: https://github.com/jarun/ddgr#installation"
    exit 1
fi

query=$1
ddgr --ducky --noprompt "$query" --reg "$REGION" &> /dev/null
