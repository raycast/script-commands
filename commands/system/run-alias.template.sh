#!/bin/zsh
# 🚨 SHEBANG SHOULD BE CHANGED IF NEEDS TO (in case you use other shells i.e #!/bin/bash)

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title runAlias
# @raycast.mode compact

# Optional parameters:
# @raycast.icon ⚙️
# @raycast.argument1 { "type": "text", "placeholder": "alias_name" }

# Documentation:
# @raycast.description Execute your custom alias
# @raycast.author Vasileios Martos
# @raycast.authorURL https://martos.dev

# 🚨 SHOULD BE CHANGED IF NEEDS TO (in case you have your aliases registered in other files)
# You can even add Multiple files if you need
source ${HOME}/.zshrc
# source ${HOME}/.bash_aliases

# exec your alias
eval $1