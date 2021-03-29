#!/bin/bash

# Note: Session X v2.1.6 required: https://www.stayinsession.com/

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Start Previous Session
# @raycast.mode silent

# Optional parameters:
# @raycast.icon images/session.png
# @raycast.packageName Session

# @Documentation:
# @raycast.description Starts a focus session in Session app with the previous intent and duration
# @raycast.author James Lyons
# @raycast.authorURL https://github.com/jamesjlyons

open "session:///start-previous"

