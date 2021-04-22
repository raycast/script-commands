#!/bin/bash

function commit_documentation() {
  if `git status | grep -q "nothing to commit"`; then
    exit 0;
  else
    extensions=false
    readme=false
    
    extensions_path="commands/extensions.json"
    readme_path="commands/README.md"
    
    while read -r file; do
      if [[ $file == $extensions_path ]]; then
        extensions=true
      fi
      
      if [[ $file == $readme_path ]]; then
        readme=true
      fi
    done <<< "$(git diff --name-only)"
    
    if $extensions && $readme; then
      git add $extensions_path $readme_path
      git commit -m "Update Script Commands documentation"
    fi
    
    exit 0;
  fi
}

function commit_executable() {
  if `git status | grep -q "nothing to commit"`; then
    exit 0;
  else
    git add -u
    git commit -m "Set scripts as executable"

    exit 0;
  fi
}

argument=$1

git config --local user.email "bot@raycast.com"
git config --local user.name "Raycast Bot"

if [[ $argument = "commit_documentation" ]]; then
  commit_documentation;
elif [[ $argument = "commit_executable" ]]; then
  commit_executable;
fi
