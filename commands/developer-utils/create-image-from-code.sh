#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Create Image from Code
# @raycast.mode silent

# Optional parameters:
# @raycast.icon ./images/ray-so.png
# @raycast.argument1 { "type": "text", "placeholder": "Title", "optional": true, "percentEncoded": true }

# Documentation:
# @raycast.description Create beautiful images of your code with https://ray.so
# @raycast.author Thomas Paul Mann
# @raycast.authorURL https://github.com/thomaspaulmann

# Customization:
# Set colors. Available options: candy, breeze, midnight or sunset
COLORS="midnight" 
# Toggle background. Available options: true or false
BACKGROUND="true"
# Toggle dark mode. Available options: true or false
DARK_MODE="true"
# Set padding. Available options: 16, 32, 64 or 128
PADDING="64"
# Set language. Available options: shell, cpp (C/C++), csharp, clojure, coffeescript, crystal, css, d, dart, diff, dockerfile, elm, erlang, fortran, gherkin,
# go, groovy, haskell, xml, java, javascript, json, jsx, julia, kotlin, latex, lisp, lua, markdown, mathematica, octave, nginx, objectivec, ocaml (F#), perl, php,
# powershell, python, r, ruby, rust, scala, smalltalk, sql, swift, typescript, (for Tsx, use jsx), twig, verilog, vhdl, xquery, yaml
LANGUAGE="auto"

# Main:
TITLE=${1:-"Untitled"}

CODE=$(pbpaste | base64)
# Urlencode any + symbols in the base64 encoded string
CODE=${CODE//+/%2B}

open "https://ray.so?#title=$TITLE&code=$CODE&colors=$COLORS&background=$BACKGROUND&darkMode=$DARK_MODE&padding=$PADDING&title=$TITLE&code=$CODE&language=$LANGUAGE"
