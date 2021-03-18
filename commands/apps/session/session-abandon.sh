#!/bin/bash

# Dependency: This script requires `Session X v2.1.6` installed: https://www.stayinsession.com/

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Abandon Session
# @raycast.mode silent

# Optional parameters:
# @raycast.icon images/session.png
# @raycast.packageName Session

# @Documentation:
# @raycast.description Starts a focus session in Session app
# @raycast.author James Lyons
# @raycast.authorURL https://github.com/jamesjlyons

open "session:///abandon"
