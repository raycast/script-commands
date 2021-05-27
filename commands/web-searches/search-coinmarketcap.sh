#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title CoinMarketCap Search
# @raycast.mode compact

# Optional parameters:
# @raycast.icon 🪙
# @raycast.argument1 { "type": "text", "placeholder": "Placeholder" }

# Documentation:
# @raycast.description Searches coinmarketcap currencies.
# @raycast.author Benedict Neo
# @raycast.authorURL https://github.com/benthecoder

open "https://coinmarketcap.com/currencies/$1"
