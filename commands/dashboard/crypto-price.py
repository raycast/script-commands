#!/usr/bin/env python3

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Crypto Price
# @raycast.mode compact

# Optional parameters:
# @raycast.icon 💰
# @raycast.packageName Money

# Documentation:
# @raycast.author Seypopi
# @raycast.authorURL https://github.com/Seypopi
# @raycast.description Gets a crypto pair prices from Binance
# @raycast.argument1 {"type": "text", "placeholder": "Pair to fetch"}

# Symbols example:
# ETHUSDT - Ethereum / USD
# LTCUSDT - Litcoin / USD
# LTCBTC  - Litecoin / Bitcoin
# ADAUSDT - Cardano / USD
# BNBUSDT - Binance Coin / USD
# DOTUSDT - Polkadot / USD
# XRPUSDT - Ripple / USD

import json
from urllib.request import urlopen
import sys
import yfinance as yf

response = {}
symbol = sys.argv[1]
try:
    with urlopen('https://api.binance.com/api/v3/ticker/24hr?symbol={}'.format(symbol)) as f:
        response  = json.load(f)
    print('{}: {:.3f} ({:+.2f}%)'.format(response['symbol'], float(response['askPrice']), float(response['priceChangePercent'])))
except:
    print('Failed loading prices..')
    sys.exit(0)
