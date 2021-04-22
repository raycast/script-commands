//
//  MIT License
//  Copyright (c) 2020-2021 Raycast. All rights reserved.
//

import Foundation
import TSCBasic

public final class Toolkit {
  lazy var fileSystem = TSCBasic.localFileSystem

  var dataManager: DataManager

  let git = GitShell()

  public init(dataManager: DataManager) {
    self.dataManager = dataManager
  }
}
