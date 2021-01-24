#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Transform Case
# @raycast.mode compact
# @raycast.packageName Developer Utils

# Optional parameters:
# @raycast.icon 🔠
# @raycast.argument1 { "type": "text", "placeholder": "L)ower, U)pper or T)itle?" }

# Documentation:
# @raycast.author Nitin Gupta
# @raycast.authorURL https://twitter.com/gniting
# @raycast.description Transform the case of clipboard content. Defaults to lower case if no conversion type is specified.

case $1 in

[Uu] ) 
    pbpaste | awk '{print toupper($0)}' | pbcopy; echo -n `pbpaste`
    ;;
[Tt] )
    pbpaste | awk '{print tolower($0)}' | awk '{for(j=1;j<=NF;j++){ $j=toupper(substr($j,1,1)) substr($j,2) }}1' | pbcopy; echo -n `pbpaste`
    ;;
* )
    pbpaste | awk '{print tolower($0)}' | pbcopy; echo -n `pbpaste`
    ;;
esac
