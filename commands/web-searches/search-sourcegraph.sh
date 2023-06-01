#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Search in sourcegraph.com
# @raycast.mode silent
# @raycast.packageName Web Searches

# Optional parameters:
# @raycast.icon https://sourcegraph.com/.assets/img/sourcegraph-mark.svg?v2
# @raycast.argument1 { "type": "text", "placeholder": "query", "percentEncoded": true }

open "https://sourcegraph.com/?q=context%3Aglobal+${1}"
