//
//  MIT License
//  Copyright (c) 2020 Raycast. All rights reserved.
//

import Foundation

struct RaycastData: Codable {
  var groups = Groups()
  var updatedAt = Date()
  var totalScriptCommands = 0
}
