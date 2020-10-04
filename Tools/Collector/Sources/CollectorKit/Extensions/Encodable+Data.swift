// 
//  MIT License
//  Copyright (c) 2020 Raycast Technologies Ltd. All rights reserved.
// 

import Foundation

extension Encodable {
    func toData() throws -> Data {
        let encoder = JSONEncoder()
        encoder.outputFormatting.insert(.prettyPrinted)
        
        if #available(macOS 10.13, *) {
            encoder.outputFormatting.insert(.sortedKeys)
        }
        
        return try encoder.encode(self)
    }
}
