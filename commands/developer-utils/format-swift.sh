#!/bin/bash

# Dependency: requires swiftformat (https://github.com/nicklockwood/SwiftFormat).
# Install via homebrew: `brew install swiftformat`

# @raycast.title Format Swift
# @raycast.author Dean Moore
# @raycast.authorURL https://github.com/moored
# @raycast.description Use [swiftformat](https://github.com/nicklockwood/SwiftFormat) to format clipboard content.

# @raycast.icon images/swift.png
# @raycast.mode silent
# @raycast.packageName Developer Utilities
# @raycast.schemaVersion 1

if ! command -v swiftformat &> /dev/null; then
      echo "swiftformat command is required (https://github.com/nicklockwood/SwiftFormat).";
      exit 1;
fi

pbpaste | swiftformat --output stdout | pbcopy
echo "Swift formatted"
