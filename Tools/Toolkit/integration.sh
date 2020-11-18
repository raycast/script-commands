#!/bin/bash

function commit() {
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
      git config --local user.email "bot@raycast.com"
      git config --local user.name "Raycast Bot"
      git add $extensions_path $readme_path
      git commit -m "Update Script Commands documentation"
    fi
    
    exit 0;
  fi
}

argument=$1

if [[ $argument = "commit" ]]; then
  commit
fi