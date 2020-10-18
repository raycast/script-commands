//
//  MIT License
//  Copyright (c) 2020 Raycast. All rights reserved.
//

import Foundation

extension Encodable {
  func toData() throws -> Data {
    let encoder = JSONEncoder()
    encoder.outputFormatting.insert(.prettyPrinted)
    encoder.outputFormatting.insert(.sortedKeys)

    return try encoder.encode(self)
  }
}
