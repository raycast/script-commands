#!/usr/bin/env python3

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Crypto
# @raycast.mode inline
# @raycast.refreshTime 5m
# @raycast.packageName Money

# Optional parameters:
# @raycast.icon 💰

# Documentation:
# @raycast.description Gets crypto prices from Binance
# @raycast.author Manan Mehta
# @raycast.authorURL https://github.com/mehtamanan

import json
from urllib.request import urlopen
import sys

# Other symbols
# ETHUSDT - Ethereum / USD
# LTCUSDT - Litcoin / USD
# LTCBTC  - Litecoin / Bitcoin
# ADAUSDT - Cardano / USD
# BNBUSDT - Binance Coin / USD
# DOTUSDT - Polkadot / USD
# XRPUSDT - Ripple / USD
SYMBOLS = [ 'BTCUSDT', 'ETHBTC' ]

# Fetch tickers from Binance for selected symbols
responses = []
for symbol in SYMBOLS:
    try:
        with urlopen('https://api.binance.com/api/v3/ticker/24hr?symbol={}'.format(symbol)) as f:
            responses.append(json.load(f))
    except:
        print('Failed loading prices..')
        sys.exit(0)

# Create and print inline message
messages = []
for r in responses:
    messages.append('{}: {:.3f} ({:+.2f}%)'.format(r['symbol'], float(r['askPrice']), float(r['priceChangePercent'])))
print('   '.join(messages))
