#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title PostgreSQL Documentation
# @raycast.mode silent
#
# Optional parameters:
# @raycast.packageName Web Searches
# @raycast.icon images/psql.png
# @raycast.argument1 { "type": "text", "placeholder": "Query", "percentEncoded": true }
#
# Documentation:
# @raycast.author Phil Salant
# @raycast.authorURL https://github.com/PSalant726
# @raycast.description Search PostgreSQL documentation

open "https://www.postgresql.org/search/?q=$1"
