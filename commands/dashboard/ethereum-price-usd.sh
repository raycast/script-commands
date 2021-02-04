#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Ethereum Price
# @raycast.mode inline
# @raycast.refreshTime 1h
# @raycast.packageName Dashboard

# Optional parameters:
# @raycast.author Clark Dinnison
# @raycast.authorURL https://github.com/cdinnison
# @raycast.description Get current Ethereum price from CoinGecko.
# @raycast.icon images/ethereum-logo.png

price=$(curl -s https://api.coingecko.com/api/v3/coins/ethereum | python -c "import json, sys; print(json.load(sys.stdin)['market_data']['current_price']['usd'])")

echo "\$${price}"