//
//  MIT License
//  Copyright (c) 2020-2021 Raycast. All rights reserved.
//

import Foundation

extension ScriptCommand {
  typealias Authors = [Author]

  struct Author: Codable {
    let name: String?
    let url: String?

    init(from decoder: Decoder) throws {
      let container = try decoder.container(keyedBy: InputCodingKeys.self)

      name = try container.decodeIfPresent(String.self, forKey: .name)
      url = try container.decodeIfPresent(String.self, forKey: .url)
    }

    func encode(to encoder: Encoder) throws {
      var container = encoder.container(keyedBy: OutputCodingKeys.self)

      try container.encode(name, forKey: .name)
      try container.encode(url, forKey: .url)
    }
  }
}

// MARK: - Keys

extension ScriptCommand.Author {
  enum InputCodingKeys: String, CodingKey {
    case url = "authorURL"
    case name = "author"
  }

  enum OutputCodingKeys: String, CodingKey {
    case url
    case name
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
    } else if let name = name {
      return name
    } else if let url = url {
      return url
    }

    return .empty
  }

  var sectionTitle: String {
    .empty
  }
}

// MARK: - Authors

extension Array: MarkdownDescriptionProtocol where Element == ScriptCommand.Author {
  var sectionTitle: String {
    .empty
  }

  var markdownDescription: String {
    var authors = String.empty

    for author in self {
      let separator = self.separator(for: author.name ?? .empty)
      authors += separator + author.markdownDescription
    }

    return authors
  }

  func separator(for currentName: String) -> String {
    if let firstAuthor = first, currentName == firstAuthor.name {
      return .empty
    } else if let lastAuthor = last, currentName == lastAuthor.name {
      return Separator.and
    }

    return Separator.comma
  }
}

extension ScriptCommand.Authors {
  enum Separator {
    static let and = " and "
    static let comma = ", "
  }
}
