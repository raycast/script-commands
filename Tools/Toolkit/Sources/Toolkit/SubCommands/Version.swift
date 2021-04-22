//
//  MIT License
//  Copyright (c) 2020-2021 Raycast. All rights reserved.
//

import ArgumentParser
import ToolkitLibrary

extension ToolkitCommand {
  struct Version: ParsableCommand {
    static var configuration = CommandConfiguration(
      abstract: "Print the current Toolkit version"
    )

    func run() throws {
      Toolkit.version()
      throw ExitCode.success
    }
  }
}
