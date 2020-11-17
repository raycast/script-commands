//
//  MIT License
//  Copyright (c) 2020 Raycast. All rights reserved.
//

import Foundation

typealias ScriptCommands = [ScriptCommand]

struct ScriptCommand: Codable {
  let schemaVersion: Int
  let title: String
  var filename: String
  let mode: Mode?
  var packageName: String?
  let icon: String?
  let authors: [Author]?
  let details: String?
  let currentDirectoryPath: String?
  let needsConfirmation: Bool?
  let refreshTime: String?

  private var leadingPath: String = ""

  enum CodingKeys: String, CodingKey {
    case schemaVersion
    case title
    case filename
    case mode
    case packageName
    case icon
    case authors
    case details = "description"
    case currentDirectoryPath
    case needsConfirmation
    case refreshTime
  }

  var iconString: String {
    func image(for url: String) -> String {
      "<img src=\"\(url)\" width=\"20\" height=\"20\">"
    }

    guard let value = icon, value.isEmpty == false else {
      return .empty
    }

    if value.isEmoji {
      return "\(value)"
    }

    if value.starts(with: "http://") || value.starts(with: "https://") {
      return image(for: value)
    }

    return image(
      for: "https://raw.githubusercontent.com/raycast/script-commands/master/commands/\(leadingPath)\(value)?raw=true"
    )
  }

  mutating func setLeadingPath(_ value: String) {
    self.leadingPath = value
  }
}

// MARK: - Encode/Decode

extension ScriptCommand {

  init(from decoder: Decoder) throws {
    let container               = try decoder.container(keyedBy: CodingKeys.self)

    // Required
    self.schemaVersion          = try container.decode(Int.self, forKey: .schemaVersion)
    self.title                  = try container.decode(String.self, forKey: .title)
    self.filename               = try container.decode(String.self, forKey: .filename)

    // Optionals
    self.mode                   = try container.decodeIfPresent(Mode.self, forKey: .mode)
    self.packageName            = try container.decodeIfPresent(String.self, forKey: .packageName)
    self.icon                   = try container.decodeIfPresent(String.self, forKey: .icon)
    self.details                = try container.decodeIfPresent(String.self, forKey: .details)
    self.currentDirectoryPath   = try container.decodeIfPresent(String.self, forKey: .currentDirectoryPath)
    self.needsConfirmation      = try container.decodeIfPresent(Bool.self, forKey: .needsConfirmation)
    self.refreshTime            = try container.decodeIfPresent(String.self, forKey: .refreshTime)
    self.authors                = try container.decodeIfPresent(Authors.self, forKey: .authors)
  }

  func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)

    try container.encode(schemaVersion, forKey: .schemaVersion)
    try container.encode(title, forKey: .title)
    try container.encode(filename, forKey: .filename)
    try container.encode(mode, forKey: .mode)
    try container.encode(packageName, forKey: .packageName)
    try container.encode(icon, forKey: .icon)
    try container.encode(details, forKey: .details)
    try container.encode(currentDirectoryPath, forKey: .currentDirectoryPath)
    try container.encode(authors, forKey: .authors)
    try container.encode(needsConfirmation, forKey: .needsConfirmation)
    try container.encode(refreshTime, forKey: .refreshTime)
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
      && lhs.authors == rhs.authors
  }
}

// MARK: - MarkdownDescription Protocol

extension ScriptCommand: MarkdownDescriptionProtocol {

  var markdownDescription: String {
    var content: String = .empty

    var author = "Raycast"
    var details = "N/A"

    if let value = self.authors {
      author = value.markdownDescription
    }

    if let value = self.details {
      details = value
    }

    let scriptPath = "\(leadingPath)\(filename)"
    let header = """
        | \(iconString) | [\(title)](\(scriptPath)) | \(details) | \(author) |
        """

    content += .newLine + header

    return content
  }

  var sectionTitle: String {
    .empty
  }
}
