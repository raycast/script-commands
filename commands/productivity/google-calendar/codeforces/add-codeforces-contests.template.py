#!/usr/bin/env python3

# Install dependencies using "pip install --upgrade google-api-python-client google-auth-httplib2 google-auth-oauthlib requests"
# Using this documentation "https://developers.google.com/calendar/api/quickstart/python#enable_the_api"
# Add "credentials.json" as "creds.json"

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Add Codeforces Contests
# @raycast.mode compact

# Optional parameters:
# @raycast.icon 🤖
# @raycast.packageName Codeforces

# Documentation:
# @raycast.description Adds codeforces contests to Google Calendar
# @raycast.author Harsh Varshney

import datetime
import os.path
import time
import json
from pip._vendor import requests
from google.auth.transport.requests import Request
from google.oauth2.credentials import Credentials
from google_auth_oauthlib.flow import InstalledAppFlow
from googleapiclient.discovery import build
from googleapiclient.errors import HttpError

SCOPES = ["https://www.googleapis.com/auth/calendar"]

def add_event(con):
  creds = None

  if os.path.exists("token.json"):
    creds = Credentials.from_authorized_user_file("token.json", SCOPES)

  if not creds or not creds.valid:
    if creds and creds.expired and creds.refresh_token:
      creds.refresh(Request())
    else:
      flow = InstalledAppFlow.from_client_secrets_file(
          "creds.json", SCOPES
      )
      creds = flow.run_local_server(port=0)

    with open("token.json", "w") as token:
      token.write(creds.to_json())

  try:
    service = build("calendar", "v3", credentials=creds)

    start_time = datetime.datetime.fromtimestamp(con["startTimeSeconds"]).strftime("%Y-%m-%dT%H:%M:%S")
    end_time = datetime.datetime.fromtimestamp(con["startTimeSeconds"] + con["durationSeconds"]).strftime("%Y-%m-%dT%H:%M:%S")
    event = {
      'summary': con["name"],
      'description': 'Codeforces Contest',
      'start': {
        'dateTime': start_time,
        'timeZone': 'Asia/Kolkata',
      },
      'end': {
        'dateTime': end_time,
        'timeZone': 'Asia/Kolkata',
      },
      'reminders': {
        'useDefault': False,
        'overrides': [
          {'method': 'email', 'minutes': 24 * 60},
          {'method': 'popup', 'minutes': 30},
        ],
      },
    }

    event = service.events().insert(calendarId='primary', body=event).execute()

  except HttpError as error:
    print(f"An error occurred: {error}")

def load_set_from_file(filename):
    try:
        with open(filename, 'r') as file:
            data = json.load(file)
            return set(data)
    except FileNotFoundError:
        return set()

def save_set_to_file(filename, data_set):
    with open(filename, 'w') as file:
        json.dump(list(data_set), file)

def jprint(obj):
    text = json.dumps(obj, sort_keys=True, indent=4)
    print(text)
    



now = time.time()
LINK = "https://codeforces.com/api/contest.list?gym=false"

res = requests.get(LINK)
resjson = res.json()

data = load_set_from_file('data.txt')

for con in resjson["result"]:
    if con["relativeTimeSeconds"] > 0:
        break
    if con["id"] not in data:
        add_event(con)
        data.add(con["id"])

save_set_to_file('data.txt',data)

print("Success")
