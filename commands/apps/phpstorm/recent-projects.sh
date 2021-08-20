#!/usr/bin/env bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Update Recent Projects
# @raycast.mode inline
#
# Optional parameters:
# @raycast.packageName PhpStorm
# @raycast.icon icon.icns
#
# Conditional parameters:
# @raycast.refreshTime 5m
#
# Requirements
# Raygen (https://github.com/pomdtr/raygen) and PhpStorm installed via JetBrains Toolbox

raygen=$(find /Library/Frameworks/Python.framework -name raygen -type f || true)
[[ -z $raygen ]] && echo "run 'pip install git+https://github.com/pomdtr/raygen.git' to use this script" && exit 1

[[ ! -d ~/Library/Application\ Support/JetBrains ]] && echo "No JetBrains support path" && exit 1

[[ ! -f ~/.config/jetbrains/bin/phpstorm ]] && echo "Install the PhpStorm script via JetBrains Toolbox" && exit 1

phpstormVersion=$(find -s ~/Library/Application\ Support/JetBrains -type d -name 'PhpStorm*' -depth 1 | tail -n 1)
[[ -z $phpstormVersion ]] && echo "could not find PhpStorm version" && exit 1

# copy the icons file from the application
[[ -f "icon.icns" ]] || cp ~/Applications/JetBrains\ Toolbox/PhpStorm.app/Contents/Resources/icon.icns .

# newest projects are at the bottom
top20=$(find "$phpstormVersion" -type f -name recentProjects.xml -exec grep -Eo 'key="[^"]*' {} \; | cut -f2 -d '"' | tail -n 20)

echo "title,command" > options.csv
for path in $top20 ; do
  echo "PhpStorm Open $(echo "$path" | rev | cut -f1 -d '/' | rev),~/.config/jetbrains/bin/phpstorm $path" >> options.csv;
done

find . -type f -name phpstorm-open-\*.bash -delete

$raygen \
  --header-row \
  --output-dir . \
  options.csv \
  --package-name PhpStorm \
  --icon ~/Applications/JetBrains\ Toolbox/PhpStorm.app/Contents/Resources/icon.icns

rm options.csv
chmod u+x phpstorm-open-*.bash