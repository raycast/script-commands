#!/usr/bin/env python3

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Generate Password
# @raycast.mode silent
# @raycast.packageName Security

# Optional parameters:
# @raycast.icon images/genpasswd.png
# @raycast.iconDark images/genpasswd-iconDark.png

# Documentation:
# @raycast.description Generates an iOS style password
# @raycast.author everdrone
# @raycast.authorURL https://github.com/everdrone
# @raycast.argument1 {"type": "text", "placeholder": "Sets (3)", "optional": true}
# @raycast.argument2 {"type": "text", "placeholder": "Length (6)", "optional": true}

import sys
import string
import random
import subprocess
from textwrap import wrap


def charset(length: int = 6) -> str:
    return ''.join(random.choices(string.ascii_lowercase, k=length))


def superset(
    length: int = 3,
    set_length: int = 6,
    numbers: int = 1,
    uppercase: int = 1,
    separator: str = '-'
) -> str:
    sets = []

    for _ in range(length):
        sets.append(charset(set_length))

    all = ''.join(sets)

    # insert uppercase
    for _ in range(uppercase):
        pick_again = True
        while pick_again:
            index = random.randrange(len(all))
            if all[index].isalpha() and all[index].islower():
                pick_again = False

        all = list(all)
        all[index] = all[index].upper()
        all = ''.join(all)

    # insert numbers
    for _ in range(numbers):
        pick_again = True
        while pick_again:
            index = random.randrange(len(all))
            if all[index].isalpha() and all[index].islower():
                pick_again = False

        all = list(all)
        all[index] = random.choice(string.digits)
        all = ''.join(all)

    # split and join with separators
    sets = wrap(all, set_length)
    result = separator.join(sets)

    subprocess.run("pbcopy", universal_newlines=True, input=result)

    return result

# stops a crash if this doesn't exist
if len(sys.argv) > 1:
    sets = sys.argv[1]
    if sets.isdigit():
        sets = int(sets)
else:
    # do not crash, set fallback value
    sets = 3
# stops a crash if this doesn't exist
if len(sys.argv) > 2:
    s_len = sys.argv[2]
    if s_len.isdigit():
        s_len = int(s_len)
else:
    s_len = 6

# This auto copies the password to the user's clipboard
generatedPassword = superset(length=sets, set_length=s_len)
subprocess.run("pbcopy", universal_newlines=True, input=generatedPassword)
print(generatedPassword)
