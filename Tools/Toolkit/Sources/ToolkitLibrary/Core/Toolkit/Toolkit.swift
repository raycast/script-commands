//
//  MIT License
//  Copyright (c) 2020 Raycast. All rights reserved.
//

import Foundation
import TSCBasic

public final class Toolkit {
  lazy var fileSystem = TSCBasic.localFileSystem

  var extensionsAbsolutePath: AbsolutePath

  public init(path: AbsolutePath) {
    extensionsAbsolutePath = path
  }
}
