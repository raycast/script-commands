#!/bin/bash

# Limitation: Endel URL scheme is not final and could be changed in the future

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Self Care
# @raycast.mode silent
# @raycast.packageName Endel
# @raycast.argument1 { "type": "text", "placeholder": "Minutes", "percentEncoded": false}
#
# Optional parameters:
# @raycast.icon images/endel.png
# @raycast.needsConfirmation false
#
# Documentation:
# @raycast.description Run Self Care scenario at Endel 
# @raycast.author Sergey Korobyin
# @raycast.authorURL https://github.com/huangsemao

MINUTES=$1
MINUTES=$((MINUTES * 60))
open "endel://?type=scenario&value=selfCare&duration=$MINUTES"