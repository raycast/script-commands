// 
//  MIT License
//  Copyright (c) 2020 Raycast Technologies Ltd. All rights reserved.
// 

import Foundation
import TSCBasic
import CollectorKit

do {
    let collector = Collector(path: ".raycast/extensions")
    try collector.start()
}
catch {
    print("Error: \(error.localizedDescription)")
}
