# Contributing to Raycast's Toolkit

Raycast's toolkit is a command-line program for automating certain repetitive tasks in this repo. At the moment the toolkit just automates the generation of the [README for the script-commands](../../commands/README.md).

## Tech Stack

The Toolkit uses the [swift programming language](https://developer.apple.com/swift/), the [swift package manager](https://swift.org/package-manager/), and [Apple's argument parser for parsing arguments](https://github.com/apple/swift-argument-parser). We also use [swiftlint](https://github.com/realm/SwiftLint) for linting our swift code.

## Code Structure

```txt
.
├── Sources
│   ├── Toolkit - Command-line tool that calls the ToolkitLibrary to automate certain tasks
│   │   ├── Extensions - Custom swift extensions specific to the CLI
│   │   └── SubCommands - Sub-commands such as version
│   └── ToolkitLibrary - Most features of the toolkit
│       ├── Core - Core functionally
│       │   ├── Documentation - Documentation generation for markdown and JSON
│       │   └── Toolkit - Public and easy to use version of the Toolkit
│       ├── Errors - Errors for the toolkit
│       ├── Extensions - Custom swift extensions
│       ├── Models - Data models
│       └── Protocols - Custom swift protocols
└── Tests - Unit tests
    └── ToolkitLibraryTests - Unit tests for the library
```

## Getting Setup

Open this folder in Xcode with the following terminal command:

```bash
open -a Xcode.app .
```

This will automatically install the swift packages for you.

## Running the CLI

1. Open up your terminal and head over to the root of this repo.
2. Run `make build`
3. Use the generated binary with `./toolkit`!

## Running the Unit Tests

See [Apple's documentation for running unit tests](https://developer.apple.com/library/archive/documentation/ToolsLanguages/Conceptual/Xcode_Overview/UnitTesting.html).
