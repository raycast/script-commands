#!/usr/bin/env python3

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Network Info
# @raycast.mode fullOutput

# @raycast.icon 🛜
# @raycast.author Kailash Yellareddy
# @raycast.authorURL https://github.com/kyellareddy

import urllib.request, json 
with urllib.request.urlopen("http://ip-api.com/json") as url:
    data = json.load(url)

    print("IP address:", data["query"])
    print("ISP:", data["isp"])

    print("City:", data["city"])
    print("Region:", data["regionName"])
    print("Country:", data["country"])
    print("ZIP:", data["zip"])