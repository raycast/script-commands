#!/bin/bash

# @raycast.title Search Python 3 Documentation
# @raycast.author Lucas Costa
# @raycast.authorURL https://github.com/lucasrcosta
# @raycast.description Search Python 3 Documentation

# @raycast.icon images/python.png
# @raycast.mode silent
# @raycast.packageName Web Searches
# @raycast.schemaVersion 1

# @raycast.argument1 { "type": "text", "placeholder": "Title", "percentEncoded": true }

open "https://docs.python.org/3/search.html?q=${1}"
