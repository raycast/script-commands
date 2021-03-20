//
//  MIT License
//  Copyright (c) 2020-2021 Raycast. All rights reserved.
//

import Foundation

extension Dictionary where Key == String, Value: Any {
  func encodeToStruct<T: Decodable>() -> T? {
    do {
      let data = try JSONSerialization.data(
        withJSONObject: self
      )

      let decoder = JSONDecoder()
      decoder.dateDecodingStrategy = .iso8601

      return try decoder.decode(T.self, from: data)
    } catch {
      return nil
    }
  }
}
