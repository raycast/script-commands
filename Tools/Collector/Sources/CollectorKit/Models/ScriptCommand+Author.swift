// 
//  MIT License
//  Copyright (c) 2020 Raycast. All rights reserved.
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

// MARK: - Comparable

extension ScriptCommand.Author: Comparable {
    
    static func < (lhs: ScriptCommand.Author, rhs: ScriptCommand.Author) -> Bool {
        guard let leftName = lhs.name, let rightName = rhs.name else {
            return false
        }
        
        return leftName < rightName
    }
    
    static func == (lhs: ScriptCommand.Author, rhs: ScriptCommand.Author) -> Bool {
        guard let leftName = lhs.name, let rightName = rhs.name else {
            return false
        }
        
        return leftName == rightName
    }
    
}

// MARK: - MarkdownDescription Protocol

extension ScriptCommand.Author: MarkdownDescriptionProtocol {
    
    var markdownDescription: String {
        if let name = name, let url = url {
            return "[\(name)](\(url))"
        }
        else if let name = name {
            return name
        }
        else if let url = url {
            return url
        }
        
        return ""
    }
    
    var sectionTitle: String {
        ""
    }

}
