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
# @raycast.author Giorgio Tropiano
# @raycast.authorURL https://github.com/everdrone

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
    print(numbers)
    # if numbers + uppercase <= set_length * length:
    #     print('The amount of numbers plus the capital letters must be less than or equal to the total amount of characters')
    #     sys.exit(1)

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


print(superset())
