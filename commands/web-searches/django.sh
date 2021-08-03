#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Search in Django Documentation
# @raycast.mode silent
# @raycast.packageName Web Searches

# Optional parameters:
# @raycast.icon images/django-light.png
# @raycast.iconDark images/django-dark.png
# @raycast.argument1 { "type": "text", "placeholder": "query", "percentEncoded": true }

# Documentation:
# @raycast.author Fernando Guerrero
# @raycast.authorURL https://github.com/devrrior

open "https://docs.djangoproject.com/en/3.2/search/?q=$1"
