#!/usr/bin/env python3

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Share Secret from Clipboard
# @raycast.mode silent

# Optional parameters:
# @raycast.icon images/doppler-logo.png
# @raycast.argument1 { "type": "text", "placeholder": "Expire Views (1)", "optional": true }
# @raycast.argument2 { "type": "text", "placeholder": "Expire Days (1)", "optional": true }
# @raycast.packageName Doppler

# @Documentation:
# @raycast.author Petr Nikolaev
# @raycast.authorURL https://github.com/PitNikola
# @raycast.description Share secret securely using https://share.doppler.com/.

import json
import sys
import urllib.request
import subprocess

expire_views = sys.argv[1]
expire_days = sys.argv[2]

if not expire_views:
    expire_views = 1

if not expire_days:
    expire_days = 1


def read_from_clipboard():
    return subprocess.check_output(
        'pbpaste', env={'LANG': 'en_US.UTF-8'}).decode('utf-8')


def write_to_clipboard(output):
    process = subprocess.Popen(
        'pbcopy', env={'LANG': 'en_US.UTF-8'}, stdin=subprocess.PIPE)
    process.communicate(output.encode())


url = "https://api.doppler.com/v1/share/secrets/plain"

payload = {
    "expire_views": expire_views,
    "expire_days": expire_views
}

payload['secret'] = read_from_clipboard()

headers = {"Content-Type": "application/json"}

request = urllib.request.Request(url)
payload = json.dumps(payload)
payload_as_bytes = payload.encode('utf-8')
request.add_header('Content-Type', 'application/json')
request.add_header('Content-Length', len(payload_as_bytes))
try:
    response = urllib.request.urlopen(request, payload_as_bytes)
except urllib.error.HTTPError as err:
    print("Failed to create secret. HTTP Error code: {}".format(err.code))
    sys.exit(1)
except urllib.error.URLError as err:
    print("Failed to create secret: {}".format(err.reason))
    sys.exit(1)
else:
    json_response = json.load(response)
    authenticated_url = json_response['authenticated_url']
    write_to_clipboard(authenticated_url)
    print("Secret URL copied to clipboard")
