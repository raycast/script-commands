# Raycast Script Commands

[Raycast](https://raycast.com) lets you control your tools with a few keystrokes and Script Commands makes it possible to execute scripts from anywhere on your desktop. They are a great way to speed up every-day tasks such as converting data, opening bookmarks or triggering dev workflows.

![Demo](https://github.com/raycast/script-commands/blob/master/screenshots/demo.gif?raw=true)

This repository contains sample commands and documentation to write your own ones.

## Awesome Script Commands

You can find a lot of useful script commands built by the community [here](https://github.com/raycast/script-commands/tree/master/commands).

Want to contribute? What a brilliant idea, please see this [contribution guide](https://github.com/raycast/script-commands/blob/master/CONTRIBUTING.md), it will help you with getting started.

## Install Script Commands

To install new commands, follow these steps:

1. Open the Extensions tab in the Raycast preferences
2. Select the Script Commands extension
3. Click `Add More Directories`
4. Select the Script Command that you want to install

![Preferences](https://github.com/raycast/script-commands/blob/master/screenshots/preferences.png?raw=true)

To get started, download one of the sample commands in this repository or [write a custom script](https://github.com/raycast/script-commands/blob/master/README.md#write-script-commands).

## How to use this repository

Grab scripts that you want to use and copy them to a separate directory on your machine (you can use [_enabled-commands](https://github.com/raycast/script-commands/blob/master/_enabled-commands) folder from this repo for this).

NOTE: We recommend against directly using script directories from this repo in Raycast to protect yourself from potential restructuring and new script commands suddenly appearing in Raycast.

## Write Script Commands

To write your custom Script Commands, go over the following steps:

1. Create a new directory for your commands
2. Open the Extensions preferences in Raycast and select Script Commands
3. Click `Add More Directories` and select your new directory (If it's empty, we generate a [template](https://github.com/raycast/script-commands/blob/master/script-command.template.sh))
4. Duplicate the generated template and remove ".template." from the file name
5. Write your script
6. Press `Reload` in the Script Commands preferences
7. Run your Script Command from the Raycast root search

Ensure your script is executable with `chmod +x <path to script>` and has a shebang at the top.

### API

The following parameters are available to customize your Script Command in Raycast:

| Name                 | Description                                                                                                                                                                                                                                                                          | Required | App Version         |
|----------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------|---------------------|
| schemaVersion        | Schema version to prepare for future changes in the API. Currently there is only version 1 available.                                                                                                                                                                                | Yes      | 0.29+               |
| title                | Display name of the Script Command that is shown as title in the root search.                                                                                                                                                                                                        | Yes      | 0.29+               |
| mode                 | Specifies how the script is executed and how the output is presented.<br>- *fullOutput:* Command prints entire output on separate view. <br>- *compact:* Command shows a toast while running in background.<br>- *silent:* Command closes the Raycast window and runs in background. <br>- *inline:* Sets the script up to be shown as refreshing dashboard command where the output is displayed inline in the item (make sure to also specify a `refreshTime`) | Yes      | 0.29+               |
| packageName          | Display name of the package that is shown as subtitle in the root search. When not provided, the name will be inferred from the script directory name.                                                                                                                               | No       | 0.29+               |
| icon                 | Icon that is displayed in the root search. Can be an emoji, a file path (relative or full) or a remote URL (only https). Supported formats for images are PNG and JPEG. Please make sure to use small icons, recommended size - 32px.                                                | No       | 0.29+               |
| currentDirectoryPath | Path from which the script is executed. Default is the path of the script.                                                                                                                                                                                                           | No       | 0.29+               |
| needsConfirmation    | Specify `true` if you would like to show confirmation alert dialog before running the script. Can be helpful with destructive scripts like "Quit All Apps" or "Empty Trash". Default value is `false`.                                                                               | No       | 0.30+               |
| refreshTime          | Specify a refresh interval for `inline` mode scripts in seconds, minutes, hours or days. Examples: `10s`, `1m`, `12h`, `1d`. Script output will be shown inline in dashboard items. *Note* that the actual times are not accurate and can vary depending on how the OS prioritizes scheduled work. The minimum allowed refresh interval is 10 seconds (use responsibly...), and the maximum allowed number of refreshing `inline` commands is 10. | No       | 0.31+ |
| argument[1...3]      | Custom arguments, see [Passing Arguments](https://github.com/raycast/script-commands#passing-arguments) section that explains in details how to use this field | No | 1.2.0+ |
| author               | Define an author name to be part of the script commands documentation | No | |
| authorURL            | Author social media, website, email or anything to help the users to get in touch | No | |
| description          | A brief description about the script command to be presented in the documentation | No | |


**⚠️ Whenever you make changes to the parameters of the Script Command, trigger the "Reload Script Directories" command in root search (v0.33+), or press "Reload" in script commands preferences, or activate "Auto Reload" in preferences so that your scripts get automatically reloaded (experimental, v0.33+). Also note that "reloading" means that script metadata is parsed and Raycast search is refreshed – the actual scripts are only run when you manually trigger their command or when an inline command with refreshTime is automatically triggered.**

### Standard Output

You can use the standard output to present messages in Raycast. Depending on the `mode`, the standard output of your scripts is differently presented. 

![Toast](https://github.com/raycast/script-commands/blob/master/screenshots/toast.png?raw=true)

In `fullOutput` the entire output is presented on a separate view, similar to a terminal. This is handy when your script generates output to consume. In `compact` mode the last line of the standard output is shown in the toast. And in `silent` mode the last line (if exists) will be shown in overlaying HUD toast after Raycast window is closed.

In `inline` mode, the first line of output will be directly shown in the command item and automatically refresh according to the specified `refreshTime`. Tip: Set your dashboard items as favorites via the action menu in Raycast

### Passing Arguments

![Custom Arguments](https://github.com/raycast/script-commands/blob/master/screenshots/custom-arguments.png?raw=true)

Use `argument[1..3]` metadata to specify custom arguments that will be displayed as inputs in the search bar when the script is selected. Value of the argument metadata paratmeter should be valid json with these fields:

| Field         | Description                                     | Required | App Version |
|---------------|-------------------------------------------------|----------|-------------|
| type          | Input type. For now only "text" value available.| Yes      | 1.2.0+      | 
| placeholder   | Placeholder for the input field.                | Yes      | 1.2.0+      |

**Maximum number of arguments:** 3 (if you feel it's not enough for your use case, please let us know via feedback or in the [Slack community](https://www.raycast.com/community))

Here's an example of a simple web search script with two arguments:
```bash
#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Search Flights
# @raycast.mode silent

# Optional parameters:
# @raycast.icon 🛩
# @raycast.packageName Web Searches
# @raycast.argument1 { "type": "text", "placeholder": "from city" }
# @raycast.argument2 { "type": "text", "placeholder": "to city" }

open "https://www.google.com/search?q=flights%20from%20${1// /%20}%20to%20${1// /%20}"
```

*💡Pro tip:* When typing alias + space, Raycast automatically will move focus to the first input field.

### Error Handling

If the script exits with a status code not equal to 0, Raycast interprets it as failed and shows a toast that the script failed to run.

### Login Shell and `$PATH`

The script is running in a non-login shell to avoid loading additional information from profiles. However, if you need to run your script as login-shell, you can specify an argument after shebang, e.g. `#!/bin/bash -l` for bash.
We also append `/usr/local/bin` to `$PATH` variable so you can use your local shell commands without any additional steps. If this is not enough, you can always extend `$PATH` by adding `export PATH='/some/extra/path:$PATH'` at the top of your script.

**👮‍♂️ We only allow Script Commands that run in a non-login shell in this repository as agreed on in our [contribution guidelines](https://github.com/raycast/script-commands/blob/master/CONTRIBUTING.md).**

### Troubleshooting

If a script doesn't appear in the commands list, make sure these requirements are met:
* Script file is executable (you can run `file <path to script>` command in terminal to check it)
* Filename doesn't contain `.template.` string
* All required metadata parameters are provided. See the table above which parameters are required.
* You use either `#` or `//` comments for metadata parameters
* You have reloaded the scripts, via 1) the "Reload" button in preferences or 2), the "Reload Script Directories" command in root search (v0.33+), or 3) automatically via the activated "Auto Reload" feature in preferences (experimental, v0.33+)

If nothing helps, try to go step by step from a [template](https://github.com/raycast/script-commands/blob/master/script-command.template.sh) script command or use one of the examples in this repo.

## Community

This is a shared place and we're always looking for new Script Commands or other ways to improve Raycast. If you have anything cool to show, please send us a pull request. If we screwed something up, please report a bug. Join our [Slack community](https://www.raycast.com/community) to brainstorm ideas with like-minded folks.
