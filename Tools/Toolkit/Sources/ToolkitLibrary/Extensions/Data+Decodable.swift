//
//  MIT License
//  Copyright (c) 2020 Raycast. All rights reserved.
//

import Foundation

extension Data {
  func decode<T: Codable>(_ type: T.Type = T.self) throws -> T {
    let decoder = JSONDecoder()
    let object = try decoder.decode(type, from: self)

    return object
  }
}
