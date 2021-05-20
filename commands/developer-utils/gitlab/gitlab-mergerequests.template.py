#!/usr/bin/env python3

# How to use this script?
# It's a template which needs further setup. Duplicate the file,
# remove `.template.` from the filename and set an Personal access token as
# well as the GitLab instance url if it is not gitlab.com in gitlabconfig.py
# You need to copy gitlabconfig.py and gitlabhelper.py next to the script command
# otherwise it won't work. gitlabconfig.py and gitlabhelper.py are shared between
# all gitlab script commands.
#
# API: https://docs.gitlab.com/ee/api


# Parameters

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Merge Requests
# @raycast.mode fullOutput

# Optional parameters:
# @raycast.packageName GitLab
# @raycast.icon images/gitlab.png

# Documentation:
# @raycast.author Michael Aigner
# @raycast.authorURL https://github.com/tonka3000
# @raycast.description Show merge requests from GitLab


# Configuration
# see gitlabconfig.py

# Main program

from gitlabhelper import GitLab
import textwrap

gitlab = GitLab()
data = gitlab.get_call("merge_requests?state=opened&scope=assigned_to_me")
print(f"GitLab Merge requests assigned to you on {gitlab.instance}/:\n")

for e in data:
  title = e.get("title")
  state = e.get("state")
  web_url = e.get("web_url")
  author = e.get("author")
  name = author.get("name")
  username = author.get("username")
  reference = e.get("references", {}).get("full")
  description = textwrap.shorten(e.get("description"), width=420, placeholder="...")
  print(f"[{state}] * {title} at {reference}\n")
  print(f"{description}\n")
  print(f"{web_url}\n")
  print(f"By {name} @{username}\n")
