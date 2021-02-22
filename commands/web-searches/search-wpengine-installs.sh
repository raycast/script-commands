#!/bin/bash

# @raycast.title Search WP Engine Installs
# @raycast.author Caleb Stauffer
# @raycast.authorURL https://github.com/crstauf
# @raycast.description Search [WP Engine](https://wpengine.com) installs.

# @raycast.icon images/wpengine-logo.png
# @raycast.mode silent
# @raycast.packageName Web Searches
# @raycast.schemaVersion 1

# @raycast.argument1 { "type": "text", "placeholder": "Query", "percentEncoded": true }

open "https://my.wpengine.com/omni_search?q=${1}"