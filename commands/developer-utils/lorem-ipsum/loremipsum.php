#!/usr/bin/env php

# Dependency: This script requires PHP
# Install PHP: https://www.php.net/manual/en/install.php
#
# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Lorem Ipsum
# @raycast.mode fullOutput
# @raycast.packageName Lorem Ipsum
#
# Optional parameters:
# @raycast.icon 📝
# @raycast.argument1 { "type": "text", "placeholder": "amount", "optional": true }
# @raycast.argument2 { "type": "text", "placeholder": "words,sentences,paragraphs", "optional": true }
#
# Documentation:
# @raycast.description Generate lorem ipsum text. Choose between words, sentences, or paragraphs (defaults to words). If amount not specified, defaults to 7 for words, 3 for sentences, and 3 for paragraphs.
# @raycast.author Robert Cooper
# @raycast.authorURL https://github.com/robertcoopercode

<?php
use utils\LoremIpsum;

require_once('utils.php');

$lipsum = new LoremIpsum;

$count = $argv[1];
$type = $argv[2];

// Default to words if type not specified
if (! in_array($type, array('words', 'sentences', 'paragraphs'))) {
    $type = "words";
}

if ($count === '') {
    switch ($type) {
        case 'words': $count = 7; break;
        case 'sentences': $count = 3; break;
        case 'paragraphs': $count = 3; break;
    }
}


if (! ctype_digit(strval($count))) {
    echo 'Not a valid number $count';
    exit(1);
}

$arg = ucfirst($lipsum->{$type}($count));

shell_exec("echo '$arg' | pbcopy");
$noun = $count > 1 ? $type : substr($type, 0, -1);

echo "Copied ${count} ${noun} to clipboard";
