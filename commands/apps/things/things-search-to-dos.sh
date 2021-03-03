#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Search To-Dos
# @raycast.mode silent

# Optional parameters:
# @raycast.icon images/things.png
# @raycast.packageName Things
# @raycast.argument1 { "type": "text", "placeholder": "Query", "percentEncoded": true }

# Documentation:
# @raycast.description Search To-Dos with a query.
# @raycast.author Things
# @raycast.authorURL https://twitter.com/culturedcode/

open "things:///search?query=$1"
