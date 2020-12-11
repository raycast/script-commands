#!/bin/bash

# Dependency: requires pa11y (https://github.com/pa11y/pa11y) and pa11y-reporter-html (https://github.com/pa11y/pa11y-reporter-html)
# Install via npm: `npm install -g pa11y pa11y-reporter-html@1.0.0`

# @raycast.title Run Pa11y
# @raycast.author Caleb Stauffer
# @raycast.authorURL https://github.com/crstauf
# @raycast.description Run [Pa11y](https://github.com/pa11y/pa11y) web accessibility tool on specified path or URL.

# @raycast.currentDirectoryPath ~/Desktop
# @raycast.icon images/pa11y-logo.png
# @raycast.mode compact
# @raycast.packageName Developer Utilities
# @raycast.schemaVersion 1

# @raycast.argument1 { "type": "text", "placeholder": "Path or URL" }

if ! command -v pa11y &> /dev/null; then
	echo "pa11y command is required (https://github.com/pa11y/pa11y).";
	exit 1;
fi

if ! command -v pa11y-reporter-html &> /dev/null; then
	echo "pa11y-reporter-html command is required for HTML output (https://github.com/pa11y/pa11y-reporter-html).";
	exit 1;
fi

pa11y --reporter html "$1" > "pa11y-report.html"
echo "Report saved to Desktop"