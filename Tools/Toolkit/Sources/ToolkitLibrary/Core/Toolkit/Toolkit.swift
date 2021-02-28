//
//  MIT License
//  Copyright (c) 2020-2021 Raycast. All rights reserved.
//

import Foundation
import TSCBasic

public final class Toolkit {
  lazy var fileSystem = TSCBasic.localFileSystem

  var extensionsAbsolutePath: AbsolutePath

  var totalScriptCommands: Int = 0

  let git = GitShell()

  public init(path: AbsolutePath) {
    extensionsAbsolutePath = path
  }
}
