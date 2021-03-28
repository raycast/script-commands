#!/usr/bin/env python
# -*- coding: utf-8 -*-

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Snake Case
# @raycast.mode inline
# @raycast.packageName Change Case

# Optional parameters:
# @raycast.icon ./images/snakecase-light.png
# @raycast.iconDark ./images/snakecase-dark.png

# Documentation:
# @raycast.author Robert Cooper
# @raycast.authorURL https://github.com/robertcoopercode
# @raycast.description Change to clipboard text to snake case

import subprocess

def getClipboardData():
    p = subprocess.Popen(["pbpaste"], stdout=subprocess.PIPE)
    data = p.stdout.read()
    return data.decode("utf-8")


def setClipboardData(data):
    p = subprocess.Popen(["pbcopy"], stdin=subprocess.PIPE)
    p.stdin.write(data.encode("utf-8"))
    p.stdin.close()

clipboard = str(getClipboardData())
result = clipboard.lower().replace(" ", "_").replace("-", "_")
setClipboardData(result)
print(result)
