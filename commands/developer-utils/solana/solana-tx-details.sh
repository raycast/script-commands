#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title View Solana Transaction
# @raycast.mode silent
# @raycast.packageName Solana

# Optional parameters:
# @raycast.icon ./images/solana-logo.png
# @raycast.argument1 { "type": "text", "placeholder": "Transaction Signature" }
# @raycast.argument2 { "type": "text", "placeholder": "Network", "optional": true }

# Documentation:
# @raycast.description Opens a Solana transaction in Solscan. Network: empty/mainnet, d/dev/devnet, t/test/testnet
# @raycast.author bjoerndotsol
# @raycast.authorURL https://github.com/bjoerndotsol

# Get transaction signature from first argument
SIGNATURE="$1"

# Get network parameter (optional, defaults to mainnet)
NETWORK_PARAM=$(echo "$2" | tr '[:upper:]' '[:lower:]') # Convert to lowercase

# Determine the network cluster based on the parameter
if [[ -z "$NETWORK_PARAM" ]]; then
    # Empty or not provided = mainnet
    CLUSTER=""
elif [[ "$NETWORK_PARAM" == d* ]]; then
    # Starts with 'd' = devnet
    CLUSTER="?cluster=devnet"
elif [[ "$NETWORK_PARAM" == t* ]]; then
    # Starts with 't' = testnet
    CLUSTER="?cluster=testnet"
else
    # Default to mainnet for unrecognized input
    CLUSTER=""
fi

# Construct the Solscan URL
URL="https://solscan.io/tx/${SIGNATURE}${CLUSTER}"

# Open the URL in the default browser
open "$URL"

echo "Opening transaction in Solscan: $URL"
