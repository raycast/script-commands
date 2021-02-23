#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Calculate Growth %
# @raycast.mode compact

# Optional parameters:
# @raycast.icon 📈
# @raycast.argument1 { "type": "text", "placeholder": "From" }
# @raycast.argument2 { "type": "text", "placeholder": "To" }

# Documentation:
# @raycast.author Petr Nikolaev
# @raycast.authorURL https://github.com/pitnikola
# @raycast.description Calculate percentage increase between "from" and "to" values.

GROWTH=$(echo "($2 / $1 - 1) * 100" | bc -l)
GROWTH=$(printf "%.1f" $GROWTH)
echo "$GROWTH" | pbcopy
echo "Growth from $1 to $2 is $GROWTH%. Copied to clipboard."
