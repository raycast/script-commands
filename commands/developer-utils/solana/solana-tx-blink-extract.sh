#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Extract Transaction from Blink Response
# @raycast.mode silent
# @raycast.packageName Solana

# Optional parameters:
# @raycast.icon ./images/solana-logo.png

# Documentation:
# @raycast.description Extract transaction from Blink endpoint in clipboard and replaces with the transaction
# @raycast.author bjoerndotsol
# @raycast.authorURL https://github.com/bjoerndotsol

# Get clipboard content
input=$(pbpaste)

# Check if "transactions" (plural) exists
if echo "$input" | grep -q '"transactions"'; then
    echo "❌ Error: Multiple transactions detected. This script only works with a single transaction."
    exit 1
fi

# Extract transaction value using grep and sed
transaction=$(echo "$input" | grep -o '"transaction"\s*:\s*"[^"]*"' | sed 's/"transaction"\s*:\s*"\([^"]*\)"/\1/')

# Check if transaction was found
if [ -z "$transaction" ]; then
    echo "❌ Error: No transaction property found in the input."
    exit 1
fi

# Copy transaction to clipboard
echo "$transaction" | pbcopy

# Show success message
echo "✅ Transaction copied to clipboard!"
