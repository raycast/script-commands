#!/usr/bin/env python3

# How to use this script?
# It's a template which needs further setup. Duplicate the file, 
# remove `.template.` from the filename and set `path_to_scripts` and 
# ignored_files vars.

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Update Community Scripts
# @raycast.mode inline
# @raycast.refreshTime 1d

# Optional parameters:
# @raycast.icon ♻️
# @raycast.packageName Utilities

# Documentation:
# @raycast.author Quentin Eude
# @raycast.authorURL https://www.github.com/qeude
import os
from glob import glob
from shutil import copyfile, rmtree
from datetime import datetime
# 🚨 SHOULD BE CHANGED ACCORDING TO YOUR NEEDS
# This should be changed with the path to your root Raycast scripts folder.
# eg: path_to_scripts = "/Users/quentin/Raycast Scripts"
path_to_scripts = "/PATH/TO/ROOT/SCRIPTS/FOLDER/"

# 🚨 SHOULD BE CHANGED ACCORDING TO YOUR NEEDS
# Keep it unchanged if you don't want to ignore scripts.
# Here you can ignore some files if you don't want to sync some of those.
# eg: ["toggle-airpods.swift", "airpodsbattery.sh"]
ignored_files = []


def get_files(root_path, extensions):
    all_files = []
    for ext in extensions:
        all_files.extend([os.path.abspath(x) for x in glob(f"{root_path}/**/*{ext}", recursive=True)])
    return all_files

repo_path = "/tmp/script-commands"
scripts_path = f"{repo_path}/commands/"

if not os.path.exists(path_to_scripts) and not os.path.isdir(path_to_scripts):
    print(f"🚨 Invalid path to scripts. Please change it in the script file here: {__file__}")
    exit()

rmtree(repo_path, ignore_errors=True)
os.system(f"git clone -q https://github.com/raycast/script-commands.git {repo_path} > /dev/null")
files = get_files(path_to_scripts, (".py", ".swift", ".sh", ".js", ".applescript", ".rb"))

for file in files:
    file_basename = os.path.basename(file)
    # We are ignoring current file to avoid weird behaviour.
    if file == __file__ or file_basename in ignored_files:
        continue
    repo_files = [os.path.abspath(x) for x in glob(f"{repo_path}/**/{file_basename}", recursive=True)]
    if repo_files:
        copyfile(repo_files[0], file)

rmtree(repo_path, ignore_errors=True)

now = datetime.now()
print(f"♻️ Udpated on {now.astimezone().strftime('%d %b %Y at %H:%M')}")
exit()
