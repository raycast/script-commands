//
//  MIT License
//  Copyright (c) 2020-2021 Raycast. All rights reserved.
//

import Foundation

extension Data {
  func decode<T: Codable>(_ type: T.Type = T.self) throws -> T {
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .iso8601

    let object = try decoder.decode(type, from: self)

    return object
  }
}
