// 
//  MIT License
//  Copyright (c) 2020 Raycast Technologies Ltd. All rights reserved.
// 

import Foundation

extension ScriptCommand {
    
    struct Author: Codable {
        let name: String?
        let url: String?
        
        enum InputCodingKeys: String, CodingKey {
            case url = "authorURL"
            case name = "author"
        }
        
        enum OutputCodingKeys: String, CodingKey {
            case url
            case name
        }
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: OutputCodingKeys.self)
            
            try container.encode(name, forKey: .name)
            try container.encode(url, forKey: .url)
        }
    }
}
