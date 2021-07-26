#!/usr/bin/env python3

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Import Kit Scripts
# @raycast.mode fullOutput

# Optional parameters:
# @raycast.icon ./images/kit_logo.png
# @raycast.packageName Script Kit

# Documentation:
# @raycast.description Convert all Script Kit scripts to Raycast Script Commands
# @raycast.author Achille Lacoin
# @raycast.authorURL https://github.com/pomdtr

import json
import os
import string
import sys

db_path = os.path.join(os.path.expanduser("~"), ".kit", "db", "scripts.json")
if not os.path.exists(db_path):
    print(
        "Kit is required! Installation Link -> https://www.scriptkit.com/",
        file=sys.stderr,
    )
    sys.exit(1)

with open(db_path) as f:
    scripts_db = json.load(f)

with open("template.txt") as f:
    RAYCAST_SCRIPT_TEMPLATE = string.Template(f.read())

for script in scripts_db["scripts"]:
    print("Importing {}...".format(script["command"]))
    raycast_script_content = RAYCAST_SCRIPT_TEMPLATE.safe_substitute(
        {
            "description": script["description"],
            "title": script["name"],
            "author": script["author"],
            "command": script["command"]
        }
    )
    output_path = os.path.join("kit_scripts", script["command"] + ".sh")
    with open(output_path, "w") as f:
        f.write(raycast_script_content)

print("\nImported {} scripts.".format(len(scripts_db["scripts"])))
