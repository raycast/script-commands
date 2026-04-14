//
// MIT License
// Copyright (c) 2020-2026 Raycast. All rights reserved.
//

import Foundation

public final class Toolkit: Sendable {
  let dataManager: DataManager
  let git = GitShell()

  public init(dataManager: DataManager) {
    self.dataManager = dataManager
  }
}
