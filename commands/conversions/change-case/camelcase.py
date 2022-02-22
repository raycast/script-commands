#!/usr/bin/env python
# -*- coding: utf-8 -*-

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Camel Case
# @raycast.mode inline
# @raycast.packageName Change Case

# Optional parameters:
# @raycast.icon ./images/camelcase-light.png
# @raycast.iconDark ./images/camelcase-dark.png

# Documentation:
# @raycast.author Robert Cooper
# @raycast.authorURL https://github.com/robertcoopercode
# @raycast.description Change to clipboard text to camel case

import subprocess
import re

always_uppercase = r"""\bXML|HTML|CSS|JSON|FYI|AOL|ATM|BBC|CD|FAQ|GAIM|GNU|GTK|HIRD|HIV
  |HURD|IEEE|IOU|IRA|IUPAC|JPEG|LCD|NAACP|NAC|NATO|NCAA|NOAD|OEM|PHP|ROM|SAT|SFMOMA|SQL|USA|VHDL|VHSIC|W3C
  |LOL|WTF\b"""
always_uppercase_re = re.compile(always_uppercase, re.I | re.X)


def __dict_replace(s, d):
    """Replace substrings of a string using a dictionary."""
    for key, value in d.items():
        s = s.replace(key, value)
    return s


SMALL = "a|an|and|as|at|but|by|en|for|if|in|of|on|or|the|to|v\.?|via|vs\.?"
PUNCT = r"""!"#$%&'‘()*+,\-./:;?@[\\\]_`{|}~"""

SMALL_WORDS = re.compile(r"^(%s)$" % SMALL, re.I)
INLINE_PERIOD = re.compile(r"[a-z][.][a-z]", re.I)
UC_ELSEWHERE = re.compile(r"[%s]*?[a-zA-Z]+[A-Z]+?" % PUNCT)
CAPFIRST = re.compile(r"^[%s]*?([A-Za-z])" % PUNCT)
SMALL_FIRST = re.compile(r"^([%s]*)(%s)\b" % (PUNCT, SMALL), re.I)
SMALL_LAST = re.compile(r"\b(%s)[%s]?$" % (SMALL, PUNCT), re.I)
SUBPHRASE = re.compile(r"([:.;?!][ ])(%s)" % SMALL)
APOS_SECOND = re.compile(r"^[dol]{1}['‘]{1}[a-z]+$", re.I)
ALL_CAPS = re.compile(r"^[A-Z\s%s]+$" % PUNCT)
UC_INITIALS = re.compile(r"^(?:[A-Z]{1}\.{1}|[A-Z]{1}\.{1}[A-Z]{1})+$")
MAC_MC = re.compile(r"^([Mm]a?c)(\w+)")


def titlecase(text):

    """
    Titlecases input text

    This filter changes all words to Title Caps, and attempts to be clever
    about *un*capitalizing SMALL words like a/an/the in the input.

    The list of "SMALL words" which are not capped comes from
    the New York Times Manual of Style, plus 'vs' and 'v'.

    """

    lines = re.split("[\r\n]+", text)
    processed = []
    for line in lines:
        all_caps = ALL_CAPS.match(line)
        words = re.split("[\t ]", line)
        tc_line = []
        for word in words:
            if all_caps:
                if UC_INITIALS.match(word):
                    tc_line.append(word)
                    continue
                else:
                    word = word.lower()

            if APOS_SECOND.match(word):
                word = word.replace(word[0], word[0].upper())
                word = word.replace(word[2], word[2].upper())
                tc_line.append(word)
                continue
            if INLINE_PERIOD.search(word) or UC_ELSEWHERE.match(word):
                tc_line.append(word)
                continue
            if SMALL_WORDS.match(word):
                tc_line.append(word.lower())
                continue

            match = MAC_MC.match(word)
            if match:
                tc_line.append(
                    "%s%s" % (match.group(1).capitalize(), match.group(2).capitalize())
                )
                continue

            hyphenated = []
            for item in word.split("-"):
                hyphenated.append(CAPFIRST.sub(lambda m: m.group(0).upper(), item))
            tc_line.append("-".join(hyphenated))

        result = " ".join(tc_line)

        result = SMALL_FIRST.sub(
            lambda m: "%s%s" % (m.group(1), m.group(2).capitalize()), result
        )

        result = SMALL_LAST.sub(lambda m: m.group(0).capitalize(), result)

        result = SUBPHRASE.sub(
            lambda m: "%s%s" % (m.group(1), m.group(2).capitalize()), result
        )

        processed.append(result)

    return "\n".join(processed)


def titlecase_plus(text):
    """The titlecase module assumes words in all UPPERCASE should be ignored.
  This works for words like HTML, FYI, ID, etc., but not generally. Just work
  around for now by going to .lower first. Then, replace any well known
  "always" uppercase"""
    text = titlecase(text.lower())

    def upcase(m):
        return m.group().upper()

    return always_uppercase_re.sub(upcase, text)

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
result = titlecase_plus(clipboard).replace(" ", "")
result = result[0].lower() + result[1:]
setClipboardData(result)
print(result)
