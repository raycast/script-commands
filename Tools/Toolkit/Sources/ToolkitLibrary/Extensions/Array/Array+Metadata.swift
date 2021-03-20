//
//  MIT License
//  Copyright (c) 2020-2021 Raycast. All rights reserved.
//

import Foundation

extension Array where Element == Metadata {
  func hasIdentifier(_ identifier: Identifier) -> Bool {
    var foundValue = false

    for item in self {
      foundValue = item.identifiers.first(where: { $0 == identifier }) != nil
    }

    return foundValue
  }
}
