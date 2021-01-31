# Raycast Toolkit

[Raycast](https://raycast.com) Toolkit helps you to generate documentation for all script commands on a predefined or customized path.

## CLI overview

```txt
OVERVIEW: A tool to generate automatized documentation

USAGE: toolkit [--version] <subcommand>

OPTIONS:
  -v, --version           Print the version and exit
  -h, --help              Show help information.

SUBCOMMANDS:
  generate-documentation  Generate the documentation in JSON and Markdown format

  See 'toolkit help <subcommand>' for detailed help.
```

## How does the Toolkit work?

The Toolkit runs on every push to master using [this GitHub Action workflow](../../.github/workflows/documentation.yml). That workflow goes through the following process:

1. Setup a version of Xcode
2. Build the Toolkit using the [Makefile](../../Makefile) located at the root of the repo
3. Run `make gen-docs-and-commit`
   1. Runs the [integration shell script](integration.sh)
   2. Commits the changes (if there are any)
4. Pushes the changes to the master branch using the Raycast bot.

## Contributing

We would love to have your contribution! Check out our [CONTRIBUTING.md](CONTRIBUTING.md) file to get started.

## Community

This is a shared place and we're always looking for new Script Commands or other ways to improve Raycast. If you have anything cool to show, please send us a pull request. If we screwed something up, please report a bug. Join our [Slack community](https://www.raycast.com/community) to brainstorm ideas with like-minded folks.
