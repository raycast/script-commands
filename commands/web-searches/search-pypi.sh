#!/bin/bash

# @raycast.title Search Python Package Index (PyPI)
# @raycast.author Lucas Costa
# @raycast.authorURL https://github.com/lucasrcosta
# @raycast.description Search Python Package Index (PyPI)

# @raycast.icon images/pip.png
# @raycast.mode silent
# @raycast.packageName Web Searches
# @raycast.schemaVersion 1

# @raycast.argument1 { "type": "text", "placeholder": "Title", "percentEncoded": true }

open "https://pypi.org/search/?q=${1}"
