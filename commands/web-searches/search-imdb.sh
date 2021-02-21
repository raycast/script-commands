#!/bin/bash

# @raycast.title Search IMDB
# @raycast.author Lucas Costa
# @raycast.authorURL https://github.com/lucasrcosta
# @raycast.description Search IMDB.

# @raycast.icon images/imdb.png
# @raycast.mode silent
# @raycast.packageName Web Searches
# @raycast.schemaVersion 1

# @raycast.argument1 { "type": "text", "placeholder": "Title", "percentEncoded": true }

open "https://www.imdb.com/find?q=${1}"
