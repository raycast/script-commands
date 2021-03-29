#!/bin/bash

# Note: Session X v2.1.6 required: https://www.stayinsession.com/

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Start Session
# @raycast.mode silent

# Optional parameters:
# @raycast.icon images/session.png
# @raycast.packageName Session

# @Documentation:
# @raycast.description Starts a focus session in Session app
# @raycast.author James Lyons
# @raycast.authorURL https://github.com/jamesjlyons

# @raycast.argument1 { "type": "text", "placeholder": "Intent", "optional": true, "percentEncoded": true }
# @raycast.argument2 { "type": "text", "placeholder": "Minutes duration", "optional": true }

open "session:///start?intent=${1}&duration=${2}"
