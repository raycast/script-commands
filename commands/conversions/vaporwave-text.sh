#!/bin/bash

# @raycast.title Vaporwave Text
# @raycast.author Adam Zethraeus
# @raycast.authorURL https://github.com/adam-zethraeus
# @raycast.description Convert clipboard text to ｖａｐｏｒｗａｖｅ
#
# @raycast.icon 🌇
#
# @raycast.mode silent
# @raycast.packageName Conversion
# @raycast.schemaVersion 1
# @raycast.argument1 { "type": "text", "placeholder": "Text to ｖａｐｏｒｗａｖｅ", "optional": false, "percentEncoded": true}

JXA=$(cat <<-END
function vaporwave(text) {
    var vaporwaveMap = {
        ' ': '　',
        '!': '！',
        '\\'': '\\'',
        '#': '＃',
        '$': '＄',
        '%': '％',
        '&': '＆',
        '\\"': '\\"',
        '(': '（',
        ')': '）',
        '*': '＊',
        '+': '＋',
        '\\,': '，',
        '-': '－',
        '.': '．',
        '/': '／',
        '0': '０',
        '1': '１',
        '2': '２',
        '3': '３',
        '4': '４',
        '5': '５',
        '6': '６',
        '7': '７',
        '8': '８',
        '9': '９',
        ':': '：',
        ';': '；',
        '<': '<',
        '=': '＝',
        '>': '>',
        '?': '？',
        '@': '＠',
        'A': 'Ａ',
        'B': 'Ｂ',
        'C': 'Ｃ',
        'D': 'Ｄ',
        'E': 'Ｅ',
        'F': 'Ｆ',
        'G': 'Ｇ',
        'H': 'Ｈ',
        'I': 'Ｉ',
        'J': 'Ｊ',
        'K': 'Ｋ',
        'L': 'Ｌ',
        'M': 'Ｍ',
        'N': 'Ｎ',
        'O': 'Ｏ',
        'P': 'Ｐ',
        'Q': 'Ｑ',
        'R': 'Ｒ',
        'S': 'Ｓ',
        'T': 'Ｔ',
        'U': 'Ｕ',
        'V': 'Ｖ',
        'W': 'Ｗ',
        'X': 'Ｘ',
        'Y': 'Ｙ',
        'Z': 'Ｚ',
        '[': '[',
        '\\\\': '\\\\',
        ']': ']',
        '^': '^',
        '_': '_',
        '\`': '\`',
        'a': 'ａ',
        'b': 'ｂ',
        'c': 'ｃ',
        'd': 'ｄ',
        'e': 'ｅ',
        'f': 'ｆ',
        'g': 'ｇ',
        'h': 'ｈ',
        'i': 'ｉ',
        'j': 'ｊ',
        'k': 'ｋ',
        'l': 'ｌ',
        'm': 'ｍ',
        'n': 'ｎ',
        'o': 'ｏ',
        'p': 'ｐ',
        'q': 'ｑ',
        'r': 'ｒ',
        's': 'ｓ',
        't': 'ｔ',
        'u': 'ｕ',
        'v': 'ｖ',
        'w': 'ｗ',
        'x': 'ｘ',
        'y': 'ｙ',
        'z': 'ｚ',
        '{': '{',
        '|': '|',
        '}': '}',
        '~': '~'
    };

    return text.split('').map((c) => {
        vc = vaporwaveMap[c];
        return vc || c;
    }).join('');
}
var app = Application('System Events');
app.includeStandardAdditions = true;
var input = decodeURIComponent("$1");
var vaporwaveOutput = vaporwave(input);
app.setTheClipboardTo(vaporwaveOutput);
vaporwaveOutput + ' copied to clipboard';

END
)

echo $JXA | osascript -l JavaScript
