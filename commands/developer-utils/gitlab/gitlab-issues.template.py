#!/usr/bin/env python3

# How to use this script?
# It's a template which needs further setup. Duplicate the file,
# remove `.template.` from the filename and set an Personal access token as
# well as the GitLab instance url if it is not gitlab.com
#
# API: https://docs.gitlab.com/ee/api


# Parameters

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Issues
# @raycast.mode fullOutput

# Conditional parameters:
# @raycast.refreshTime 1h

# Optional parameters:
# @raycast.packageName GitLab
# @raycast.icon images/gitlab.png

# Documentation:
# @raycast.author Michael Aigner
# @raycast.authorURL https://github.com/tonka3000
# @raycast.description Show issues from GitLab


# Configuration
# The easiest way to use this script command is to copy the whole
# gitlab directory to e.g. _enabled-commands directory and remove
# the .template from the script-command filename which you want to
# use.
# You need to copy gitlabconfig.py and gitlabhelper.py if you just
# want to use only one or two script commands.
#
# Don't forget to set your config in the gitlabconfig.py

# Main program

from gitlabhelper import GitLab
gitlab = GitLab()
data = gitlab.get_call("issues?state=opened&scope=assigned_to_me")
print(f"GitLab Issues assigned to you on {gitlab.instance}:\n")
for e in data:
  title = e.get("title")
  reference = e.get("references", {}).get("full")
  print(f"* {title} at {reference}")
