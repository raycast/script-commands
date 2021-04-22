//
//  MIT License
//  Copyright (c) 2020-2021 Raycast. All rights reserved.
//

import Foundation

struct Metadata: Codable {
  let date: Date
  var identifiers: Identifiers
}

// MARK: - Equatable

extension Metadata: Equatable {
  static func == (lhs: Metadata, rhs: Metadata) -> Bool {
    lhs.date == rhs.date
  }
}
