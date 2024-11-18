#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Calculate CAGR Percentage
# @raycast.mode compact
# @raycast.packageName Math

# Optional parameters:
# @raycast.argument1 { "type": "text", "placeholder": "From" }
# @raycast.argument2 { "type": "text", "placeholder": "To" }
# @raycast.argument3 { "type": "text", "placeholder": "Years" }

# Documentation:
# @raycast.author Samuel Barton
# @raycast.authorURL https://github.com/samueldbarton
# @raycast.description Calculate the CAGR between "from" and "to" values over given "years," then copy the result.

CAGR=$(echo "scale=4; e( l($2 / $1) / $3 ) - 1" | bc -l)
CAGR=$(echo "scale=2; $CAGR * 100" | bc -l)
CAGR=$(printf "%.2f" "$CAGR")
echo "$CAGR" | pbcopy
echo "The CAGR from $1 to $2 over $3 years is $CAGR%. CAGR copied to clipboard."