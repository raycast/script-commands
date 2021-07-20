#!/usr/bin/env python3

# Dependency: This script requires `wikipedia` python module installed: https://github.com/goldsmith/Wikipedia
# Install via pip: `pip install wikipedia`

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Wikipedia Search
# @raycast.mode fullOutput
# @raycast.packageName Wikipedia

# Optional parameters:
# @raycast.icon images/wikipedia.png
# @raycast.argument1 { "type": "text", "placeholder": "Search Term" }

# Documentation:
# @raycast.description Search Wikipedia and display the result in Raycast
# @raycast.author Juan I. Serra
# @raycast.authorURL https://twitter.com/jiserra

import sys
import wikipedia
import webbrowser
# This is to disable the wikipedia module warning about the parser in BeatifulSoup
import warnings
warnings.filterwarnings("ignore")

# Define some colors to work with
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

# Define the argument
search = sys.argv[1]

# Catch the exception when there's more than one definition
try:
    wikisearch = wikipedia.page(search)
except wikipedia.exceptions.DisambiguationError as e:
    print(red('Which one do you mean?\n'))
    print(e)
except wikipedia.exceptions.PageError:
    print(red(f"Sorry, there's not a Wikipedia page on {yellow(search.title())}"))
else:
    print(yellow(wikisearch.title))
    print('\n')
    print(wikisearch.summary)