#!/usr/bin/env python3
# -*- coding: UTF-8 -*-

# Dependency: Requires translate-shell (https://www.soimort.org/translate-shell)
# Install with Homebrew: `brew install translate-shell`
# or install with MacPorts: `sudo port install translate-shell`

# Set required paths to binaries required for translate-shell.
GAWK='/usr/local/bin/gawk'
TRANS='/usr/local/bin/trans'

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Translate Shell
# @raycast.mode fullOutput

# Optional parameters:
# @raycast.argument1 {"type": "text", "placeholder": "Query"}
# @raycast.argument2 {"type": "text", "placeholder": "from", "optional": true }
# @raycast.argument3 {"type": "text", "placeholder": "to", "optional": true}
# @raycast.icon 🌍

# Documentation:
# @raycast.author Marcel Bochtler
# @raycast.authorURL https://github.com/MarcelBochtler
# @raycast.description Translate text using translate-shell.

# Set the default language pair.
# Allows to set a default language-pair that can be used to translate in both 
# directions without setting the 'from' and 'to' languages.
FROM_LANG_DEFAULT = 'de'
TO_LANG_DEFAULT = 'en'

import json, os, sys, subprocess

from_language = FROM_LANG_DEFAULT
if sys.argv[2]:
    from_language = sys.argv[2]

to_language = TO_LANG_DEFAULT
if sys.argv[3]:
    to_language = sys.argv[3]

colors = {
  'green': '\033[92m',
  'yellow': '\033[93m',
  'red': '\033[91m',
  'grey': '\033[90m',
  'white': '\033[97m',
  'end': '\033[0m',
}

def green(message):
    return f"{colors['green']}{message}{colors['end']}"

def yellow(message):
    return f"{colors['yellow']}{message}{colors['end']}"

def red(message):
    return f"{colors['red']}{message}{colors['end']}"

def grey(message):
    return f"{colors['grey']}{message}{colors['end']}"

def white(message):
    return f"{colors['white']}{message}{colors['end']}"

def translate(lang, query):
    cmd = f"""
    # Ensure gawk is available in PATH, as translate-shell requires it.
    PATH="$(dirname {GAWK}):$PATH"
    {TRANS} '{lang}' -dump '{query}' | /usr/bin/tail -n +2  | /usr/bin/head -n 1
    """

    stream = os.popen(cmd)
    rawJson = stream.read()

    parsedJson = json.loads(rawJson)
    translations = parsedJson[1]
    if translations is not None:
       translation = parsedJson[0][0][0]
       subprocess.run("pbcopy", universal_newlines=True, input=translation)

    return translations


def print_translations(translations):
    # TODO: Limit the number of translations so no scrolling in the results is required.
    if translations is None:
        print(yellow('No translations found.'))
    else:
        for i, translation in enumerate(translations):
            wordType = translation[0]
            print(grey(wordType))

            translationWithBackTranslation = translation[2]
            for j, t in enumerate(translationWithBackTranslation):
                translatedWord = t[0]
                backTranslations = t[1]
                if i == 0 and j == 0:
                    print(f'  {yellow(translatedWord)} 📋')
                else:
                    print(f'  {green(translatedWord)}')

                print(white('    ' + ', '.join(backTranslations) + '\n'))


query = sys.argv[1]
translations = translate(f'{from_language}:{to_language}', query)

if translations is None:
    translations = translate(f'{to_language}:{from_language}', query)
    # TODO: If second attempt failed, use result from first attempt and offer
    #  a "Did you mean ..." functionality.
    print_translations(translations)
else:
    print_translations(translations)
