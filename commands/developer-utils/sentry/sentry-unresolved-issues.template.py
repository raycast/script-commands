#!/usr/bin/env python3

# How to use this script?
# It's a template which needs further setup. Duplicate the file,
# remove `.template.` from the filename and set an API token as
# well as the Sentry organization and project.
#
# API: https://docs.sentry.io/api/events/list-a-projects-issues/


# Parameters

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Unresolved Issues
# @raycast.mode inline

# Conditional parameters:
# @raycast.refreshTime 1h

# Optional parameters:
# @raycast.packageName Sentry
# @raycast.icon images/sentry.png
# @raycast.iconDark images/sentry-dark.png

# Documentation:
# @raycast.author Thomas Paul Mann
# @raycast.authorURL https://github.com/thomaspaulmann
# @raycast.description Show unresolved issues of the last 24 hours from Sentry.


# Configuration

# API token with `project:read` scope (https://sentry.io/settings/account/api/auth-tokens/)
API_TOKEN = ""

# Slug of organization the issues belong to
ORGANIZATION = ""

# Slug of project the issues belong to
PROJECT = ""

if not API_TOKEN:
  print("No API token provided")
  exit(1)

if not ORGANIZATION or not PROJECT:
  print("No Sentry organization or project provided")
  exit(1)


# Main program

import json
import urllib.request

url = f"https://sentry.io/api/0/projects/{ORGANIZATION}/{PROJECT}/issues/?statsPeriod=24h&query=is:unresolved"
request = urllib.request.Request(url)
request.add_header("Authorization", f"Bearer {API_TOKEN}")

try:
  response = urllib.request.urlopen(request)
except urllib.error.HTTPError as e:
  print("Error code: ", e.code)
  print("Failed to get unresolved issues from Sentry")
  exit(1)
except urllib.error.URLError as e:
  print("Error reason: ", e.reason)
  print("Failed to reach Sentry")
  exit(1)
else:
  data = response.read().decode("utf-8")
  unresolved_issues = json.loads(data)
  unresolved_issues_count = len(unresolved_issues)
  has_unresolved_issues = unresolved_issues_count > 0
  
  message = f"{unresolved_issues_count} in the last 24 hours" if has_unresolved_issues else "None in the last 24 hours"
  print(message)
