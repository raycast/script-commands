#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title DOGE Price
# @raycast.mode inline
# @raycast.refreshTime 1h
# @raycast.packageName Dashboard

# Optional parameters:
# @raycast.icon images/dogecoin-logo.png

# Documentation:
# @raycast.description Checking DOGE coin price
# @raycast.author Clu Soh
# @raycast.authorURL https://github.com/designedbyclu


price=$(curl -s https://api.coingecko.com/api/v3/coins/dogecoin | python -c "import json, sys; print(json.load(sys.stdin)['market_data']['current_price']['usd'])")

echo "\$${price}"