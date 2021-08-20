# Contributing

Thank you for your interest in contributing to Raycast Script Commands! Here you will find simple guidelines that can help you with getting started.

- [Contributing](#contributing)
  - [Guidelines](#guidelines)
    - [Git and Pull Requests](#git-and-pull-requests)
    - [Folder structure](#folder-structure)
    - [English style convention](#english-style-convention)
    - [File naming convention](#file-naming-convention)
    - [Metadata convention](#metadata-convention)
    - [Scripts that require additional modification](#scripts-that-require-additional-modification)
    - [Scripts that require installation of runtimes and dependencies](#scripts-that-require-installation-of-runtimes-and-dependencies)
    - [Scripts that require installation of apps](#scripts-that-require-installation-of-apps)
    - [Bash profiles and environmental variables](#bash-profiles-and-environmental-variables)
    - [Auto generated files](#auto-generated-files)
  - [Examples](#examples)

## Guidelines

### Git and Pull Requests

Please make sure that your pull request makes it easy for the reviewer to understand what the change is about (fill in the pull request template) and keep your change focused (do not create a PR containing multiple complex Script Commands).

In order to keep the Git history clean, we prefer if you rebase your branch on top of master, so that we can do a fast-forward merge back to master. Make sure to use descriptive commit messages (incl. proper spelling), and squash commits ("fix typo") already on your end.

### Folder structure

Try to bundle scripts that are related in a directory / sub-directory. Avoid having generic folders with lots of different commands. For example instead of having one `media` directory that contains integrations with different services, it's better to create sub-directories for each service:

```markdown
. commands
└─ media
   ├─ spotify
   ├─ apple-music
   └─ youtube
```

Reasoning behind it: To avoid automatically including scripts that people may not be interested in. E.g. if you're using Spotify scripts, there is a lower chance you will need to access Apple Music.

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

### English style convention

Use American English spelling and style for your command metadata. 
To make sure you use the right version, refer to [Wikipedia](https://en.wikipedia.org/wiki/Comparison_of_American_and_British_English) or use [British to American English Converter](https://www.infoenglish.net/british-to-american-english/)

### File naming convention

Use lowercased, dash-case format for script files and directories, and use proper file extensions: Applescript should be `.applescript`, Swift should be `.swift`, Bash should be `.sh`, etc.
Example: `spotify-next-track.applescript`

### Metadata convention

- **Title:** Raycast's UI adopts title-cased strings for all command titles as per Apple's Human Interface Guidelines. Please make sure your command title follows this pattern to look good between other commands.
- **Mode:** Use the `silent` mode for commands that are instant, e.g. `Toggle Hidden Files`. Use the `compact` mode for long-running tasks, e.g. some networking requests. Use the `fullOutput` mode for commands that print more information, e.g. output some file content. And use the `inline` mode for dashboard items, e.g. `Current Weather`.
- **Package Name:** While `packageName` is an optional parameter and if it's missing Raycast will derive it from the directory name, it is required in this repository to improve portability. Make sure to always provide it in your script commands.

### Scripts that require additional modification

1. Ensure that comments include instructions on how to start using the script. E.g. you might need to provide API token, username or tweak parameters.
2. Add `.template.` to the file name for scripts that need modifications. Then scripts won't be automatically parsed by Raycast and people who want to use it will need to copy the file and remove `.template.` part.

Example: `github-notifications.template.sh`

*NOTE:* This might change as soon as we introduce a better way to provide parameters / environmental variables.

### Scripts that require installation of runtimes and dependencies

Most scripts are either written in Bash or AppleScript. We also allow Swift and Node runtimes; however, always check if there's a strong need for those runtimes since they don't come pre-installed on macOS. We have non-technical users who don't bother installing a Node runtime just to perform a simple function.

Some general guidelines:
- First, ask yourself if you can build the Script Command without any dependencies. Less or no dependencies make it easier for others to adopt your command and make it more portable.
- A question you can ask yourself is whether a dependency is "deep" or "shallow": a deep dependency hides complex functionality behind a simple interface. A shallow dependency is the opposite. Avoid using shallow dependencies and check whether there are built-in Unix tools (curl, awk, sed, etc.) that can solve the same problem without much code.
- Also consider transitive dependencies and security aspects. The npm ecosystem, for instance, has been notorious for pulling-in dependencies for trivial tasks, sometimes exposing the user to security issues.

If you still need a dependency, follow these guidelines:

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
   
### Scripts that require installation of apps

Some Scripts control apps and therefore require them to be installed. Make sure to hint the requirement and add guidance on how to install it at the top of the script:

```
#!/bin/bash

# Note: Plash v2.2.0 required
# Install via Mac App Store: https://apps.apple.com/app/id1494023538

# @raycast.schemaVersion 1
```

### Bash profiles and environmental variables

All Script Commands are executed in a non-login shell to avoid additional information loaded from profiles that aren't relevant to Raycast. With an argument after a shebang, you can run a script in a login shell, e.g. `#!/bin/bash -l`. We don't allow Script Commands that make use of this feature in this repository. Mainly to guarantee easy portability, explicit injection of information and best performance.

*NOTE:* We will add support for environmental variables in Raycast and keep track of it in [this issue](https://github.com/raycast/script-commands/issues/77).

### Auto generated files

There are some files auto generated by our Toolkit after each commit pushed to this repository, for now, this is the list of files:

- `commands/README.md`
- `commands/extensions.json`

Remember to keep these files unchanged. All manual changes will be lost when our integration workflow is performed. The information used to fill these files is collected from the Script Commands pushed to this repository. No changes on your side in these files are necessary.

## Examples

Some examples to get started:

- **[Apple Music Play](commands/media/apple-music/apple-music-play.applescript)**: An `AppleScript` to start playing music.
- **[Sentry Unresolved Issues](commands/developer-utils/sentry/sentry-unresolved-issues.template.py):** A `Python` script that fetches information from an API and parses the JSON response.
- **[Slack Set Status](commands/communication/slack/set-slack-status.template.sh)**: A `Bash` script that sends a JSON payload with cURL.
