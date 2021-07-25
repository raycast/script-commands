#!/usr/bin/env python3

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Import Kit Scripts
# @raycast.mode fullOutput

# Optional parameters:
# @raycast.icon ./img/kit_logo.png
# @raycast.packageName Kit

# Documentation:
# @raycast.description Convert all scripts defined in ~/.kenv/scripts to raycast scripts
# @raycast.author Achille Lacoin
# @raycast.authorURL https://github.com/pomdtr

import string
import json
import os

with open("template.txt") as f:
    RAYCAST_SCRIPT_TEMPLATE = string.Template(f.read())

db_path = os.path.join(os.path.expanduser("~"), ".kit", "db", "scripts.json")
with open(db_path) as f:
    scripts_db = json.load(f)

for script in scripts_db["scripts"]:
    print("Importing {}...".format(script['command']))
    raycast_script_content = RAYCAST_SCRIPT_TEMPLATE.safe_substitute(script)
    output_path = os.path.join("kit_scripts", script["command"] + ".sh")
    with open(output_path, "w") as f:
        f.write(raycast_script_content)

print("\nImported {} scripts.".format(len(scripts_db["scripts"])))
