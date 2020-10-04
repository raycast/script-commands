// 
//  MIT License
//  Copyright (c) 2020 Raycast. All rights reserved.
// 

import Foundation

extension Collector {
    enum Error: Swift.Error {
        case extensionsFolderNotFound(String)
    }
}

extension Collector.Error: CustomStringConvertible, LocalizedError {
    var description: String {
        switch self {            
            case .extensionsFolderNotFound(let folder):
                return "Extensions folder not found. Expected: \(folder)"
        }
    }
}
