# Contributing to Raycast's Toolkit

Raycast Toolkit is a command-line application for automating repetitive tasks in this repo. At the moment the Toolkit automates the generation of the [Awesome Script Commands](../../commands/README.md) and the [extensions.json](../../commands/extensions.json) which contains information about each Script Command.

## Tech Stack

- [Swift](https://developer.apple.com/swift) 5.3
- [Swift Package Manager](https://github.com/apple/swift-package-manager/)
- [Swift Argument Parser](https://github.com/apple/swift-argument-parser)
- [SwiftLint](https://github.com/realm/SwiftLint)

## Code Structure

```txt
.
├── Sources
│   ├── Toolkit - Command-line Interface tool that makes calls to ToolkitLibrary. This is the interface used by the user or by the CI.
│   │   ├── Extensions - Custom Swift extensions specific to the CLI
│   │   └── SubCommands - Sub-commands are the interfaces that are exposed to the user
│   └── ToolkitLibrary - The main library
│       ├── Core - Core functionally
│       │   ├── Documentation - Documentation generation for Markdown and JSON
│       │   └── Toolkit - Contains the public interface which will be consumed by the Toolkit CLI
│       ├── Errors - Errors for the Toolkit
│       ├── Extensions - Custom Swift extensions
│       ├── Models - Data models
│       └── Protocols - Custom Swift protocols
└── Tests - Unit tests
    └── ToolkitLibraryTests - Unit tests for the library
```

## Getting Setup

Open this folder in Xcode with the following terminal command:

```bash
open -a Xcode.app .
```

Xcode will automatically download the Swift Packages for you.

## Running the CLI

1. Open up your terminal and head over to the root of this repo.
2. Run `make build`
3. Use the generated binary with `./toolkit`!

## Running the Unit Tests

See [Apple's documentation for running unit tests](https://developer.apple.com/library/archive/documentation/ToolsLanguages/Conceptual/Xcode_Overview/UnitTesting.html).
