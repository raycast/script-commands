#!/usr/bin/env python3

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Crypto
# @raycast.mode inline
# @raycast.refreshTime 5m

# Optional parameters:
# @raycast.icon 🚀

# @Documentation:
# @raycast.description Gets crypto prices from Binance
# @raycast.author Manan Mehta
# @raycast.authorURL github.com/mehtamanan

import json
from urllib.request import urlopen
import sys

SYMBOLS = [ 'BTCUSDT', 'ETHBTC' ]
responses = []

for symbol in SYMBOLS:
    try:
        with urlopen('https://api.binance.com/api/v3/ticker/24hr?symbol={}'.format(symbol)) as f:
            responses.append(json.load(f))
    except:
        print('Failed loading prices..')
        sys.exit(0)

print('   '.join([ '{}: {:.3f} ({:+.2f}%)'.format(r['symbol'], float(r['askPrice']), float(r['priceChangePercent'])) for r in responses ]))
