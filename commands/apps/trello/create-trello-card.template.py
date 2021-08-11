#!/usr/bin/env python3

# Dependency: This script requires the following Python libraries: `sys`, `requests`, `dateparser`
# Install them with `pip install {library}`

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Create Card
# @raycast.packageName Trello
# @raycast.mode compact

# Optional parameters:
# @raycast.icon 🤖
# @raycast.argument1 { "type": "text", "placeholder": "Card title" }
# @raycast.argument2 { "type": "text", "placeholder": "Due date (e.g. today)", "optional": true }

# Documentation:
# @raycast.description Create a new Trello card
# @raycast.author Michael Francis
# @raycast.authorURL https://github.com/mikefrancis


import sys
import requests
import dateparser

# To generate an API key/token, head to https://trello.com/app-key
TRELLO_KEY = ''
TRELLO_TOKEN = ''
# To find the Board ID, head to https://api.trello.com/1/members/me/boards?key={TRELLO_KEY}&token={TRELLO_TOKEN}
# To find the List ID, head to https://api.trello.com/1/boards/{BOARD_ID}/lists?key={TRELLO_KEY}&token={TRELLO_TOKEN}
TRELLO_LIST_ID = ''

if TRELLO_KEY == '' or TRELLO_TOKEN == '' or TRELLO_LIST_ID == '':
  print('Command not configured correctly, missing either TRELLO_KEY, TRELLO_TOKEN or TRELLO_LIST_ID')
  exit(1)

name = sys.argv[1]
due_date = sys.argv[2]

payload = {
  'key': TRELLO_KEY,
  'token': TRELLO_TOKEN,
  'idList': TRELLO_LIST_ID,
  'name': name,
  'pos': 'top',
}

if due_date:
  datetime = dateparser.parse(due_date)
  payload['due'] = datetime.strftime('%Y-%m-%d')

response = requests.post('https://api.trello.com/1/cards', data=payload)

if not response.ok :
  print(response.reason)
  exit(1)
