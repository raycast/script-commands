//
//  MIT License
//  Copyright (c) 2020 Raycast. All rights reserved.
//

import Foundation

import ArgumentParser
import ToolkitLibrary
import TSCBasic

struct ToolkitCommand: ParsableCommand {

  static var configuration = CommandConfiguration(
    commandName: "toolkit",
    abstract: "A tool to generate automatized documentation",
    subcommands: [
      GenerateDocumentation.self,
      Version.self
    ]
  )
}

ToolkitCommand.main()
