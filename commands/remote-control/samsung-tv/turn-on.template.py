#!/usr/bin/env python3

# How to use this script?
# It's a template which needs further setup. Duplicate the file,
# remove `.template.` from the filename and set your TVs MAC Address as a parameter.
# You need to copy samsunghelper.py, samsungshortcuts.py and samsungexceptions.py next to the script command
# otherwise it won't work.

# Dependency: This script requires the following Python libraries: `wakeonlan`
# Install them with `pip3 install wakeonlan`

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Turn On TV
# @raycast.mode compact

# Optional parameters:
# @raycast.packageName Samsung TV
# @raycast.icon images/logo.png

# Documentation:
# @raycast.author Darryl Brooks
# @raycast.authorURL https://github.com/DarrylBrooks97
# @raycast.description Turns on a Samsung TV.

import wakeonlan

# Your TVs MAC Address should be within the TV's network settings menu
mac_address = '00:00:00:00:00:00'

wakeonlan.send_magic_packet(mac_address)