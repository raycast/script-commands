#!/usr/bin/env python3

# How to use this script?
# It's a template which needs further setup. Duplicate the file,
# remove `.template.` from the filename and set `path_to_scripts` and
# ignored_files vars.

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Update Community Scripts
# @raycast.description Updates community Script Commands to their last available version from the GitHub repository.
# @raycast.mode compact
# @raycast.refreshTime 1d

# Optional parameters:
# @raycast.icon ♻️
# @raycast.packageName Utilities

# Documentation:
# @raycast.author Quentin Eude
# @raycast.authorURL https://www.github.com/qeude
import os
import json
from glob import glob
from shutil import copyfile, rmtree
from datetime import datetime
from dataclasses import dataclass


# 🚨 SHOULD BE CHANGED ACCORDING TO YOUR NEEDS
# This should be changed with the path to your root Raycast scripts folder.
# eg: path_to_scripts = "/Users/quentin/Raycast Scripts"
path_to_scripts = "/PATH/TO/ROOT/SCRIPTS/FOLDER/"

# 🚨 SHOULD BE CHANGED ACCORDING TO YOUR NEEDS
# Keep it unchanged if you don't want to ignore scripts.
# Here you can ignore some files if you don't want to sync some of those.
# eg: ["toggle-airpods.swift", "airpodsbattery.sh"]
ignored_files = []


@dataclass
class RepoScriptFile:
    filename: str
    updated_at: datetime

@dataclass
class LocalScriptFile:
    filename: str
    full_path: str

def get_files(root_path, extensions):
    all_files = []
    for ext in extensions:
        all_files.extend([LocalScriptFile(filename=os.path.basename(x), full_path=os.path.abspath(x)) for x in glob(f"{root_path}/**/*{ext}", recursive=True)])
    return all_files

def save_last_update_date():
    with open(f"{os.path.dirname(__file__)}/.update-scripts-command", "w") as file:
        file.write(datetime.now().astimezone().isoformat())

def read_last_update_date():
    try:
        with open(f"{os.path.dirname(__file__)}/.update-scripts-command", "r") as file:
            return datetime.fromisoformat(file.read())
    except:
        return None

repo_path = "/tmp/script-commands"
scripts_path = f"{repo_path}/commands/"

def get_files_to_update(base_date=None, base_local_files=None):
    flatten = lambda t: [item for sublist in t for item in sublist]

    def find(key, dictionary):
        for k, v in dictionary.items():
            if k == key:
                yield v
            elif isinstance(v, dict):
                for result in find(key, v):
                    yield result
            elif isinstance(v, list):
                for d in v:
                    for result in find(key, d):
                        yield result

    with open(f"{repo_path}/commands/extensions.json") as json_file:
        data = json.load(json_file)
        script_files = [RepoScriptFile(updated_at=datetime.fromisoformat(file.get("updatedAt")), filename=file.get("filename"))
            for file in flatten(find("scriptCommands", data))]
        if base_date is not None:
            script_files = [f for f in script_files if f.updated_at > base_date]
        base_filenames = [f.filename for f in base_local_files]
        return [f.filename for f in script_files if f.filename in base_filenames]

if not os.path.exists(path_to_scripts) and not os.path.isdir(path_to_scripts):
    print(f"🚨 Invalid path to scripts. Please change it in the script file here: {__file__}")
    exit()

rmtree(repo_path, ignore_errors=True)
# Doing this here to avoid problems with updated scripts during the process.
now = datetime.now()
os.system(f"git clone -q https://github.com/raycast/script-commands.git {repo_path} > /dev/null")
local_scripts_files = get_files(path_to_scripts, (".py", ".swift", ".sh", ".js", ".applescript", ".rb"))
last_updated_date = read_last_update_date()
files_to_update = get_files_to_update(last_updated_date, local_scripts_files)

for file in files_to_update:
    file_basename = os.path.basename(file)
    # We are ignoring current file to avoid weird behavior.
    if file == __file__ or file_basename in ignored_files:
        continue
    repo_files = [os.path.abspath(x) for x in glob(f"{repo_path}/**/{file_basename}", recursive=True)]
    if repo_files:
        copyfile(repo_files[0], file)

rmtree(repo_path, ignore_errors=True)

save_last_update_date()

if not files_to_update:
    print("🙌 Everything is up to date.")
elif len(files_to_update) == 1:
    print("♻️ Updated 1 script.")
else:
    print(f"♻️ Updated {len(files_to_update)} scripts.")
exit()
