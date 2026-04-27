//
// MIT License
// Copyright (c) 2020-2026 Raycast. All rights reserved.
//

import ArgumentParser
import ToolkitLibrary

extension ToolkitCommand {
  struct Version: ParsableCommand {
    static let configuration = CommandConfiguration(
      abstract: "Print the current Toolkit version",
    )

    func run() throws {
      Toolkit.version()
      throw ExitCode.success
    }
  }
}
