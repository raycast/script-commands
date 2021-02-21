#!/usr/bin/env python3

# Parameters
# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title What Day Is...
# @raycast.mode silent

# Optional parameters:
# @raycast.packageName Conversions
# @raycast.icon 📅
# @raycast.argument1 { "type": "text", "placeholder": "Date (YYYY-MM-DD)" }


# Documentation:
# @raycast.author Phil Salant
# @raycast.authorURL https://github.com/PSalant726
# @raycast.description Return the day of the week on which a particular date falls.

import sys
from datetime import datetime as dt

print(dt.fromisoformat(sys.argv[1]).strftime("%A"))
