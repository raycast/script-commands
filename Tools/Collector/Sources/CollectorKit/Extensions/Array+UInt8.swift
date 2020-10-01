// 
//  MIT License
//  Copyright (c) 2020 Raycast Technologies Ltd. All rights reserved.
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
