#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Search in Stack Overflow
# @raycast.mode silent

# Optional parameters:
# @raycast.icon images/stackoverflow.png
# @raycast.packageName Web Searches

# Documentation:
# @raycast.author Pierre-Alexandre Bourdais
# @raycast.authorURL https://github.com/Seypopi
# @raycast.description Search in stackoverflow
# @raycast.argument1 { "type": "text", "placeholder": "query", "percentEncoded": true}

# Argument example:
# [tag] search within a tag
# user:1234 search by author
# answers:0 unanswered questions
# score:3 posts with a 3+ score
# is:question type of post
# isaccepted:yes search within status
# more info here https://stackoverflow.com/help/searching

open "https://stackoverflow.com/search?q=${1}"
