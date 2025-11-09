#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Open in Solana Inspector
# @raycast.mode silent
# @raycast.packageName Solana

# Optional parameters:
# @raycast.icon ./images/solana-logo.png
# @raycast.argument1 { "type": "text", "placeholder": "Signed transaction (base64)" }

# Documentation:
# @raycast.description Extracts the message from a signed Solana transaction and opens Explorer's Inspector with it.
# @raycast.author bjoerndotsol
# @raycast.authorURL https://github.com/bjoerndotsol

# This script decodes a full signed Solana transaction (base64)
# and reconstructs a Solana Explorer Inspector link.
# Supports both legacy and versioned transactions.

TX_BASE64=$(printf "%s" "$1" | tr -d '[:space:]')

if [[ -z "$TX_BASE64" ]]; then
  echo "❌ Please provide a base64-encoded transaction."
  exit 1
fi

# Use Python to extract the message portion (skip signatures)
MESSAGE_BASE64=$(python3 - "$TX_BASE64" <<'PY'
import sys, base64, binascii, urllib.parse

try:
    tx_b64 = sys.argv[1]
    b = base64.b64decode(tx_b64)
except (binascii.Error, ValueError) as e:
    print(f"Error decoding base64: {e}", file=sys.stderr)
    sys.exit(1)

# Transaction format:
# [u8: num_signatures] [signatures * 64 bytes] [message...]
# The message may start with a version byte (0x80 | version) for versioned transactions
if not b or len(b) < 2:
    print("Transaction too short", file=sys.stderr)
    sys.exit(1)

num_signatures = b[0]
offset = 1 + num_signatures * 64

if offset >= len(b):
    print(f"Invalid transaction: offset {offset} >= length {len(b)}", file=sys.stderr)
    sys.exit(1)

# Extract message (includes version byte if present)
msg = b[offset:]
msg_b64 = base64.b64encode(msg).decode()

# URL encode (double encoding for Explorer)
encoded = urllib.parse.quote(msg_b64, safe='')
print(encoded)
PY
)

# Check if extraction failed
if [[ $? -ne 0 ]] || [[ -z "$MESSAGE_BASE64" ]]; then
  echo "❌ Could not extract transaction message."
  exit 1
fi

# Dummy signature array for Inspector (Explorer only needs valid JSON)
DUMMY_SIGS='["1111111111111111111111111111111111111111111111111111111111111111"]'
ENCODED_SIGS=$(python3 -c "import urllib.parse,sys;print(urllib.parse.quote(sys.argv[1]))" "$DUMMY_SIGS")

URL="https://explorer.solana.com/tx/inspector?signatures=${ENCODED_SIGS}&message=${MESSAGE_BASE64}"

open "$URL"
echo "✅ Opening Solana Explorer Inspector"
