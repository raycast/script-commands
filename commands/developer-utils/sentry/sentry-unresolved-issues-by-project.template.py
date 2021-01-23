#!/usr/bin/env python3

# How to use this script?
# It's a template which needs further setup. Duplicate the file,
# remove `.template.` from the filename and set an API token as
# well as the Sentry organization.
#
# API: https://docs.sentry.io/api/events/list-a-projects-issues/


# Parameters

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Unresolved Issues By Project
# @raycast.mode fullOutput

# Conditional parameters:
# @raycast.refreshTime 1h

# Optional parameters:
# @raycast.packageName Sentry
# @raycast.icon images/sentry.png
# @raycast.iconDark images/sentry-dark.png
# @raycast.argument1 { "type": "text", "placeholder": "Project" }

# Documentation:
# @raycast.author Phil Salant
# @raycast.authorURL https://github.com/PSalant726
# @raycast.author Thomas Paul Mann
# @raycast.authorURL https://github.com/thomaspaulmann
# @raycast.description Show unresolved issues in the last 24 hours (by project) from Sentry.


# Configuration

# API token with `project:read` scope (https://sentry.io/settings/account/api/auth-tokens/)
API_TOKEN = ""
if not API_TOKEN:
  print("No API token provided")
  exit(1)

# Slug of organization the issues belong to
ORGANIZATION = ""
if not ORGANIZATION:
  print("No Sentry organization provided")
  exit(1)

# Main program
import json, sys, urllib.request
from datetime import datetime as dt

project = sys.argv[1]
if not project:
  print("No Sentry project provided")
  exit(1)

request = urllib.request.Request(
  method="GET",
  url=f"https://sentry.io/api/0/projects/{ORGANIZATION}/{project}/issues/?statsPeriod=24h&query=is:unresolved",
  headers={ "Authorization": f"Bearer {API_TOKEN}" }
)

try:
  response = urllib.request.urlopen(request)
except urllib.error.HTTPError as e:
  print("Failed to get unresolved issues from Sentry:")
  print(e.code, e.reason)
  exit(1)
except urllib.error.URLError as e:
  print("Failed to reach Sentry:")
  print("Error:", e.reason)
  exit(1)
else:
  unresolved_issues = json.loads(response.read().decode("utf-8"))
  unresolved_issues_count = len(unresolved_issues)

  if unresolved_issues_count == 0:
    print("No unresolved issues in the last 24 hours.")
  else:
    issue_text = "issue" if unresolved_issues_count == 1 else "issues"
    print(f"{unresolved_issues_count} unresolved {issue_text} in the last 24 hours:")

    for i, issue in enumerate(unresolved_issues, 1):
      last_seen = dt.strptime(issue['lastSeen'], "%Y-%m-%dT%H:%M:%S.%fZ")

      print(f"  {i}. {issue['title']} ({last_seen.strftime('%b %d, %Y at %I:%M %p')})")
      print(f"     {issue['permalink']}\n")
