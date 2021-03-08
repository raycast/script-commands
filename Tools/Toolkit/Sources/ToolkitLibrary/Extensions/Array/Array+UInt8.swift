//
//  MIT License
//  Copyright (c) 2020-2021 Raycast. All rights reserved.
//

import Foundation

extension Array where Element == UInt8 {
  var data: Data {
    var array = self

    return Data(
      bytes: &array,
      count: array.count
    )
  }
}
