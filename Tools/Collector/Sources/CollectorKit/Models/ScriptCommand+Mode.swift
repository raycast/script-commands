// 
//  MIT License
//  Copyright (c) 2020 Raycast Technologies Ltd. All rights reserved.
// 

import Foundation

extension ScriptCommand {
    
    enum Mode: String, Codable {
        case fullOutput
        case compact
        case silent
    }
}
