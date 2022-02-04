#!/usr/bin/env python3

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title LaTeX Calculator
# @raycast.mode silent
# @raycast.packageName Math
#
# Optional parameters:
# @raycast.icon 🧮
# @raycast.argument1 { "type": "text", "placeholder": "\\frac{4}{2}}", "optional": true}
#
# Documentation:
# @raycast.description Evaluate LaTeX expressions and get the product copied to your clipboard
# @raycast.author Matt Gleich
# @raycast.authorURL https://mattglei.ch

import pyperclip
from sympy.parsing.latex import parse_latex
import sys

result = float(parse_latex(sys.argv[1]).evalf())

if result.is_integer():
    result = round(result)

pyperclip.copy(result)
print(f"Copied {result} to clipboard")

