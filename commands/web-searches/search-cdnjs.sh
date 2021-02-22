#!/bin/bash

# @raycast.title Search cdnjs
# @raycast.author Caleb Stauffer
# @raycast.authorURL https://github.com/crstauf
# @raycast.description Search [cdnjs.com](https://cdnjs.com/) for library.

# @raycast.icon images/cloudflare-logo.png
# @raycast.mode silent
# @raycast.packageName Web Searches
# @raycast.schemaVersion 1

# @raycast.argument1 { "type": "text", "placeholder": "Library", "percentEncoded": true }

open "https://cdnjs.com/libraries?q=${1}"