//
//  MIT License
//  Copyright (c) 2020 Raycast. All rights reserved.
//

import ArgumentParser
import ToolkitLibrary

struct VersionOptions: ParsableArguments {
  @Flag(name: .shortAndLong, help: "Print the version and exit")
  var version: Bool = false

  func validate() throws {
    if version {
      Toolkit.version()
      throw ExitCode.success
    }
  }
}
