#!/usr/bin/env python3

# Dependency: This script require playground (https://github.com/JohnSundell/Playground).

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Create View Based
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🕊
# @raycast.argument1 { "type": "text", "placeholder": "Destination Path", "optional": true }
# @raycast.argument2 { "type": "text", "placeholder": "GitHub/Gist URL", "optional": true }
# @raycast.argument3 { "type": "text", "placeholder": "Dependencies", "optional": true }

# @raycast.packageName Swift Playgrounds

# Documentation:
# @raycast.description Create and open a new view based Swift Playground
# @raycast.author Quentin Eude
# @raycast.authorURL https://github.com/qeude

import sys
import os
from datetime import datetime
from shutil import which

def safe_get(array, index):
    try:
        return array[index]
    except IndexError:
        return None


if which("playground") is None:
    print("playground is required (https://github.com/JohnSundell/Playground).")
    exit(1)

default_path=os.path.abspath("/tmp")

destination_path=safe_get(sys.argv, 1) or default_path
url_to_open=safe_get(sys.argv, 2)
dependencies=safe_get(sys.argv, 3)

if os.path.isdir(destination_path):
    destination_path=os.path.join(destination_path, datetime.now().astimezone().isoformat())

command = f"playground -v -t '{destination_path}'"
if url_to_open:
    command = command + f" -u '{url_to_open}'"
if dependencies:
    command = command + f" -d '{dependencies}'"

os.system(command)
