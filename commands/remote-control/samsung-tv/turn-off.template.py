#!/usr/bin/env python3

# How to use this script?
# It's a template which needs further setup. Duplicate the file,
# remove `.template.` from the filename and place your TVs IP address within the host parameter
# You need to copy samsunghelper.py, samsungshortcuts.py, and samsungexceptions.py next to 
# the enabled script command otherwise it won't work.

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Turn Off TV
# @raycast.mode compact

# Optional parameters:
# @raycast.packageName Samsung TV
# @raycast.icon images/logo.png

# Documentation:
# @raycast.author Darryl Brooks
# @raycast.authorURL https://github.com/DarrylBrooks97
# @raycast.description Turns off a Samsung TV.

import sys
import os
from samsunghelper import SamsungTVWS

sys.path.append('../')

# Your TVs IP Address should be within the TV's network settings menu
ip_address = '192.168.0.00'

# This will allow one time authentication on the TV.
# Caches TV ssl token for later use.
token_file = os.path.dirname(os.path.realpath(__file__)) + '/tv-token.txt'

tv = SamsungTVWS(host=ip_address, port=8002,token_file=token_file)

tv.shortcuts().power()