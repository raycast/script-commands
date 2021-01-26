#!/usr/bin/env python3

# Parameters
# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title NextDNS Status
# @raycast.mode inline

# Conditional parameters:
# @raycast.refreshTime 1h

# Optional parameters:
# @raycast.packageName Dashboard
# @raycast.icon images/nextdns.png

# Documentation:
# @raycast.author Phil Salant
# @raycast.authorURL https://github.com/PSalant726
# @raycast.description Check if this machine is using NextDNS.

import json, urllib.request

request = urllib.request.Request(
    method="GET",
    url="https://test.nextdns.io",
    headers={ "User-Agent": "curl" },
)

try:
    response = urllib.request.urlopen(request)
except urllib.error.HTTPError as e:
    print("Failed to get status from NextDNS:", e.code, e.reason)
    exit(1)
except urllib.error.URLError as e:
    print("Failed to reach NextDNS.", "Error:", e.reason)
    exit(1)
else:
    resp_json = json.loads(response.read().decode("utf-8"))
    status = resp_json["status"]

    if status == "ok":
        print("✅ ", resp_json["deviceName"], "is using NextDNS via", resp_json["protocol"])
    else:
        print("❌  This device is not using NextDNS")
