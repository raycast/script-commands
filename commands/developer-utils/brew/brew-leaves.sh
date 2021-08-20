#!/bin/bash
#
# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Leaves
# @raycast.mode fullOutput
# @raycast.packageName Brew
#
# Optional parameters:
# @raycast.icon 🍺
#
# Documentation:
# @raycast.description Show list of installed brew formulae that are not dependencies of other installed formula.
# @raycast.author owpac
# @raycast.authorURL https://github.com/Owpac

if ! command -v brew &> /dev/null; then
  echo "brew command is required (https://brew.sh).";
  exit 1;
fi

brew leaves
