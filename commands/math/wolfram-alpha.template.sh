#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Wolfram Alpha
# @raycast.mode fullOutput

# Optional parameters:
# @raycast.icon images/wolfram-alpha.png
# @raycast.argument1 { "type": "text", "placeholder": "query" }
# @raycast.packageName Math

# Documentation:
# @raycast.description Use Wolfram Alpha to answer your query
# @raycast.author es183923
# @raycast.authorURL https://github.com/es183923

# Configuration

# Get a Wolfram Alpha API app (https://products.wolframalpha.com/api/) and put in the id below
WA_APP_ID=""

# units (`metric` or `imperial`)
units="metric"

encodedtext=$(echo $1 | curl -Gso /dev/null -w %{url_effective} --data-urlencode @- "" | cut -c 3- || true)
result=$(curl -s "http://api.wolframalpha.com/v1/result?appid=${WA_APP_ID}&i=${encodedtext}&units=${units}")
echo $result

