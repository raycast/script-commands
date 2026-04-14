//
// MIT License
// Copyright (c) 2020-2026 Raycast. All rights reserved.
//

import ArgumentParser
import Foundation
import ToolkitLibrary

@main
struct ToolkitCommand: AsyncParsableCommand {
  static let configuration = CommandConfiguration(
    commandName: "toolkit",
    abstract: "A tool to generate automatized documentation",
    subcommands: [
      GenerateDocumentation.self,
      SetExecutable.self,
      Version.self,
    ],
  )
}
