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
    let details: String?
    let currentDirectoryPath: String?
    
    private var groupPath: String?
    
    enum CodingKeys: String, CodingKey {
        case schemaVersion
        case title
        case mode
        case packageName
        case icon
        case author
        case details = "description"
        case currentDirectoryPath
    }
    
    var iconString: String {
        guard let icon = icon, icon.isEmpty == false else {
            return .empty
        }
        
        if icon.isEmoji {
            return icon
        }
        
        guard let groupPath = self.groupPath else {
            return .empty
        }
        
        let imageURL = "https://raw.githubusercontent.com/raycast/script-commands/master/\(groupPath)/\(icon)?raw=true"
        let image = "![](\(imageURL))"
        
        return image
    }
    
    mutating func setGroupPath(for group: Group) {
        self.groupPath = group.path
    }
}

// MARK: - Encode/Decode

extension ScriptCommand {
    
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
        self.details                = try container.decodeIfPresent(String.self, forKey: .details)
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
        try container.encode(details, forKey: .details)
        try container.encode(currentDirectoryPath, forKey: .currentDirectoryPath)
        try container.encode(author, forKey: .author)
    }
    
}

// MARK: - Comparable

extension ScriptCommand: Comparable {
    
    static func < (lhs: ScriptCommand, rhs: ScriptCommand) -> Bool {
        lhs.title < rhs.title
    }
    
    static func == (lhs: ScriptCommand, rhs: ScriptCommand) -> Bool {
        lhs.title == rhs.title
            && lhs.schemaVersion == rhs.schemaVersion
            && lhs.author == rhs.author
    }
    
}

// MARK: - MarkdownDescription Protocol

extension ScriptCommand: MarkdownDescriptionProtocol {
    
    var markdownDescription: String {
        var content: String = .empty
        
        let header = """
        | \(iconString) | \(title) |
        | ------------| ---------- |
        """
        
        content += .newLine + header
        
        if let value = details {
            content += .newLine + "| Description | \(value) |"
        }
        
        if let value = author {
            content += .newLine + "| Author | \(value.markdownDescription) |"
        }
        
        if let value = packageName {
            content += .newLine + "| Package Name | \(value.capitalized) |"
        }
        
        if let value = mode {
            content += .newLine + "| Mode | \(value.rawValue) |"
        }
        
        content += .newLine + "| Schema Version | \(schemaVersion) |"
        
        if let value = currentDirectoryPath {
            content += .newLine + "| Current Path Directory | \(value) |"
        }
        
        return content
    }
    
    var sectionTitle: String {
        .empty
    }
    
}
