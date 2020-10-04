// 
//  MIT License
//  Copyright (c) 2020 Raycast Technologies Ltd. All rights reserved.
// 

import Foundation

typealias ScriptCommands = [ScriptCommand]

struct ScriptCommand: Codable {
    let schemaVersion: Int
    let title: String
    let mode: Mode?
    var packageName: String?
    let icon: String?
    let author: Author?
    let description: String?
    let currentDirectoryPath: String?
    
    enum CodingKeys: String, CodingKey {
        case schemaVersion
        case title
        case mode
        case packageName
        case icon
        case author
        case description
        case currentDirectoryPath
    }
    
    init(from decoder: Decoder) throws {
        let container               = try decoder.container(keyedBy: CodingKeys.self)
        let authorContainer         = try decoder.container(keyedBy: Author.InputCodingKeys.self)
        
        // Required
        self.schemaVersion          = try container.decode(Int.self, forKey: .schemaVersion)
        self.title                  = try container.decode(String.self, forKey: .title)
        
        // Optionals
        self.mode                   = try container.decodeIfPresent(Mode.self, forKey: .mode)
        self.packageName            = try container.decodeIfPresent(String.self, forKey: .packageName)
        self.icon                   = try container.decodeIfPresent(String.self, forKey: .icon)
        self.description            = try container.decodeIfPresent(String.self, forKey: .description)
        self.currentDirectoryPath   = try container.decodeIfPresent(String.self, forKey: .currentDirectoryPath)

        let name = try authorContainer.decodeIfPresent(String.self, forKey: .name)
        let url = try authorContainer.decodeIfPresent(String.self, forKey: .url)
        
        let author = Author(
            name: name,
            url: url
        )
        
        if name != nil || url != nil {
            self.author = author
        }
        else {
            self.author = nil
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
    
        try container.encode(schemaVersion, forKey: .schemaVersion)
        try container.encode(title, forKey: .title)
        try container.encode(mode, forKey: .mode)
        try container.encode(packageName, forKey: .packageName)
        try container.encode(icon, forKey: .icon)
        try container.encode(description, forKey: .description)
        try container.encode(currentDirectoryPath, forKey: .currentDirectoryPath)
        try container.encode(author, forKey: .author)
    }
// MARK: - MarkdownDescription Protocol

extension ScriptCommand: MarkdownDescriptionProtocol {
    
    var markdownDescription: String {
        var content = """
        \n\n
        | \(iconString) | \(title) |
        | ------------| ---------- |
        """
        
        if let value = details {
            content += "\n| Description | \(value) |"
        }
        
        if let value = author {
            content += "\n| Author | \(value.markdownDescription) |"
        }

        if let value = packageName {
            content += "\n| Package Name | \(value.capitalized) |"
        }

        if let value = mode {
            content += "\n| Package Name | \(value.description) |"
        }
        
        content += "\n| Schema Version | \(schemaVersion) |"
        
        if let value = currentDirectoryPath {
            content += "\n| Current Path Directory | \(value) |"
        }
        
        return content
    }
    
    var sectionTitle: String {
        ""
    }
    
}
}
