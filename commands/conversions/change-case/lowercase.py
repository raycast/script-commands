#!/usr/bin/env python
# -*- coding: utf-8 -*-

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Lowercase
# @raycast.mode inline
# @raycast.packageName Change Case

# Optional parameters:
# @raycast.icon ./images/lowercase-light.png
# @raycast.iconDark ./images/lowercase-dark.png

# Documentation:
# @raycast.author Robert Cooper
# @raycast.authorURL https://github.com/robertcoopercode
# @raycast.description Change clipboard text to lowercase

import subprocess

def getClipboardData():
    p = subprocess.Popen(["pbpaste"], stdout=subprocess.PIPE)
    data = p.stdout.read()
    return tryDecode(data)

def setClipboardData(data):
    p = subprocess.Popen(["pbcopy"], stdin=subprocess.PIPE)
    p.stdin.write(tryEncode(data))
    p.stdin.close()

def tryDecode(s):
    try:
        return s.decode('utf-8')
    except:
        return s

def tryEncode(s):
    try:
        return s.encode('utf-8')
    except:
        return s

clipboard = str(getClipboardData())
result = clipboard.lower()
setClipboardData(result)
print(result)
