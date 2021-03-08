//
//  MIT License
//  Copyright (c) 2020-2021 Raycast. All rights reserved.
//

import Foundation

extension UInt8 {
  var data: Data {
    var int = self

    return Data(
      bytes: &int,
      count: MemoryLayout<UInt8>.size
    )
  }
}
