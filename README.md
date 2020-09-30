# Raycast Script Commands

[Raycast](https://raycast.com) lets you control your tools with a few keystrokes and Script Commands makes it possible to execute scripts from anywhere on your desktop. They are a great way to speed up every-day tasks such as converting data, opening bookmarks or triggering dev workflows.

![Demo](https://github.com/raycast/script-commands/blob/master/screenshots/demo.gif?raw=true)

This repository contains sample commands and documentation to write your own ones.

## Install Script Commands

To install new commands, follow these steps:

1. Open the Extensions tab in the Raycast preferences
2. Select the Script Commands extension
3. Click `Add More Directories`
4. Select the Script Command that you want to install

![Preferences](https://github.com/raycast/script-commands/blob/master/screenshots/preferences.png?raw=true)

To get started, download one of the sample commands in this repository or [write a custom script](https://github.com/raycast/script-commands/blob/master/README.md#write-script-commands).

## Write Script Commands

To write your custom Script Commands, go over the following steps:

1. Create a new directory for your commands
2. Open the Extensions preferences in Raycast and select Script Commands
3. Click `Add More Directories` and select your new directory (If it's empty, we generate a template)
4. Duplicate the generated template and remove ".template." from the file name
5. Write your script
6. Press `Reload` in the Script Commands preferences
7. Run your Script Command from the Raycast root search

Ensure your script is executable with `chmod +x <path to script>` and has a shebang at the top.

### API

The following parameters are available to customize your Script Command in Raycast:

| Name                 | Description                                                                                                                                                                                                                                                                   | Required |
|----------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------|
| schemaVersion        | Schema version to prepare for future changes in the API. Currently there is only version 1 available.                                                                                                                                                                         | Yes        |
| title                | Display name of the Script Command that is shown as title in the root search.                                                                                                                                                                                                 | Yes        |
| mode                 | Specifies how the script is executed and how the output is presented.<br>- *fullOutput:* Command prints entire output on separate view. <br>- *compact:* Command shows a toast while running in background.<br>- *silent:* Command closes the Raycast window and runs in background. | Yes        |
| packageName          | Display name of the package that is shown as subtitle in the root search. When not provided, the name will be inferred from the script directory name.                                                                                                                        | No        |
| icon                 | Icon that is displayed in the root search. Can be an emoji, a file path (relative or full) or a remote URL (only https). Supported formats for images are PNG and JPEG. Please make sure to use small icons, recommended size - 32px.                                         | No       |
| currentDirectoryPath | Path from which the script is executed. Default is the path of the script.                                                                                                                                                                                                    | No       |

Whenever you make changes to the parameters of the Script Command, go to the preferences and reload the Script Commands.

### Standard Output

You can use the standard output to present messages in Raycast. Depending on the `mode`, the standard output of your scripts is differently presented. 

![Toast](https://github.com/raycast/script-commands/blob/master/screenshots/toast.png?raw=true)

In `fullOutput` the entire output is presented on a separate view, similar to a terminal. This is handy when your script generates output to consume. In `compact` mode the last line of the standard output is shown in the toast. And in `silent` nothing is shown and the Raycast window is closed. This mode is good for quick interactions.

### Error Handling

If the script exits with a status code not equal to 0, Raycast interprets it as failed and shows a toast that the script failed to run.

## Community

This is a shared place and we're always looking for new Script Commands or other ways to improve Raycast. If you have anything cool to show, please send us a pull request. If we screwed something up, please report a bug. Join our [Slack community](https://join.slack.com/t/raycastcommunity/shared_invite/zt-hhzj9i4m-D5~HwnTRsJKrcZmVDJ4mkg) to brainstorm ideas with like-minded folks.
