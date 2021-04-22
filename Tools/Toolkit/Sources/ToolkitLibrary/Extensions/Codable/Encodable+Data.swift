//
//  MIT License
//  Copyright (c) 2020-2021 Raycast. All rights reserved.
//

import Foundation

extension Encodable {
  func toData() throws -> Data {
    let encoder = JSONEncoder()
    encoder.outputFormatting.insert(.prettyPrinted)
    encoder.outputFormatting.insert(.sortedKeys)
    encoder.dateEncodingStrategy = .iso8601

    return try encoder.encode(self)
  }
}
