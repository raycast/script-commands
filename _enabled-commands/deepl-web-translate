#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title DeepL Web Translate
# @raycast.mode silent

# Optional parameters:
# @raycast.icon images/deepl.png
# @raycast.packageName Web Searches
# @raycast.argument1 { "type": "text", "placeholder": "text", "percentEncoded": true, "optional": true }
# @raycast.argument2 { "type": "text", "placeholder": "to", "optional": true }
# @raycast.argument3 { "type": "text", "placeholder": "from", "optional": true }

# Documentation:
# @raycast.description Translate text on the DeepL website. Translates to a default language if no "to" argument is given.
# @raycast.author Jono Hewitt
# @raycast.authorURL https://github.com/jonohewitt

### Language codes:

# Bulgarian: bg
# Chinese simplified: zh
# Czech: cs
# Danish: da
# Dutch: nl
# English (American and British): en
# Estonian: et
# Finnish: fi
# German: de
# Greek: el
# Hungarian: hu
# Italian: it
# Japanese: ja
# Latvian: lv
# Lithuanian: lt
# Polish: pl
# Portuguese (Brazilian and Portuguese): pt
# Romanian: ro
# Russian: ru
# Slovak: sk
# Slovenian: sl
# Spanish: es
# Swedish: sv

# It's not usually necessary to specify a "from" language as DeepL will auto-detect it, however on very short inputs it can be helpful

# You can enter no inputs just to bring up the DeepL website

# Configure your default language code here:
defaultLang="en"

inputText=$1
toLang=$2
fromLang=$3

if [ -z $2 ]; then
   toLang=$defaultLang
fi

if [ -z $3 ]; then
   fromLang=$defaultLang
fi

open "https://www.deepl.com/translator#$fromLang/$toLang/$inputText"
