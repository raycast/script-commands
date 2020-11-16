# Contributing

Thank you for your interest in contributing to Raycast Script Commands! Here you will find simple guidelines that can help you with getting started.

## Guidelines

### Folder structure

Try to bundle scripts that are related in a directory / sub-directory. Avoid having generic folders with lots of different commands. For example instead of having one `media` directory that contains integrations with different services, it's better to create sub-directories for each service:

```markdown
. commands
└─ media
   ├─ spotify
   ├─ apple-music
   └─ youtube
```

Reasoning behind it: to avoid automatically including scripts that people may not be interested in. E.g. if you're using Spotify scripts, there is a lower chance you will need to access Apple Music.

Images should go into dedicated `images` folder:

```markdown
. commands
└─ media
   └─ spotify
      └─ images
         └─ spotify-logo.png
      └─ spotify-next-track.applescript
      └─ spotify-prev-track.applescript
```

### File naming convention

Use dash-case format for script files and directories, and use proper file extensions: Applescript should be `.applescript`, Swift should be `.swift`, Bash should be `.sh`, etc.
Example: `spotify-next-track.applescript`

### `packageName` metadata

While `packageName` is an optional parameter and if it's missing Raycast will derive it from the directory name, it is required in this repository to improve portability. Make sure to always provide it in your script commands.

### Scripts that require additional modification

1. Ensure that comments include instructions on how to start using the script. E.g. you might need to provide API token, username or tweak parameters.
2. Add `.template.` to the file name for scripts that need modifications. Then scripts won't be automatically parsed by Raycast and people who want to use it will need to copy the file and remove `.template.` part.

Example: `github-notifications.template.sh`

NOTE: This might change as soon as we introduce a better way to provide parameters / enviromental variables.

### Scripts that require installation of dependencies

1. At the top of the file add a comment section explicitly stating the dependency and how to install it. Example:
   ```
   #!/bin/bash

   # Dependency: This script requires `jq` cli installed: https://stedolan.github.io/jq/
   # Install via homebrew: `brew install jq`

   # @raycast.schemaVersion 1
   # @raycast.title Prettify JSON from Clipboard
   ...
   ```


2. Make sure you have code that handles missing dependency. Example:
   ```bash
   if ! command -v download &> /dev/null; then
	     echo "download command is required (https://github.com/kevva/download-cli).";
	     exit 1;
   fi
   ```
