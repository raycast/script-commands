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
# @raycast.title To-Dos
# @raycast.mode fullOutput

# Optional parameters:
# @raycast.packageName GitLab
# @raycast.icon images/gitlab.png

# Documentation:
# @raycast.author Michael Aigner
# @raycast.authorURL https://github.com/tonka3000
# @raycast.description Show todos from GitLab


# Configuration
# see gitlabconfig.py

# Main program

from gitlabhelper import GitLab
gitlab = GitLab()
data = gitlab.get_call("todos")
print(f"GitLab To-Do List on {gitlab.instance}:\n")
todo_count = len(data)
print(f"To Do {todo_count}")
for todo in data:
  project_name = todo.get("project", {}).get("name_with_namespace")
  title = todo.get("target", {}).get("title")
  web_url = todo.get("target", {}).get("web_url")
  print(f"* {title} at {project_name}")
  print(f"{web_url}\n")