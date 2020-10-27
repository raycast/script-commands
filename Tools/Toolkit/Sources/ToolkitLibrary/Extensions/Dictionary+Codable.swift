//
//  MIT License
//  Copyright (c) 2020 Raycast. All rights reserved.
//

import Foundation

extension Dictionary where Key == String, Value: Any {
  func encodeToStruct<T: Decodable>() -> T? {
    guard let data = try? JSONSerialization.data(withJSONObject: self, options: []) else {
      return nil
    }

    return try? JSONDecoder().decode(T.self, from: data)
  }
}
