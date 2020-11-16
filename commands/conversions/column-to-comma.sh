#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Column to Comma
# @raycast.mode silent

clipboard=$(pbpaste)

echo "$clipboard" | gsed ':a;N;$!ba;$s/\n/,/g' | pbcopy 
