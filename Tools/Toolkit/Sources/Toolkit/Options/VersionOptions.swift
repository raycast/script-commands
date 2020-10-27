//
//  MIT License
//  Copyright (c) 2020 Raycast. All rights reserved.
//

import ArgumentParser

struct VersionOptions: ParsableArguments {
  @Flag(name: .shortAndLong, help: "Print the version and exit")
  var version: Bool = false

  func validate() throws {
    if version {
      print("Raycast Toolkit")
      print("Current version: 0.1")
      throw ExitCode.success
    }
  }
}
