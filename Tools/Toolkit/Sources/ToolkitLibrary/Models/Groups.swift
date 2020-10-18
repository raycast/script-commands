//
//  MIT License
//  Copyright (c) 2020 Raycast. All rights reserved.
//

import Foundation

typealias Groups = [Group]

struct Group: Codable {
  let name: String
  let path: String
  let scriptCommands: ScriptCommands
}

// MARK: - MarkdownDescription Protocol

extension Group: MarkdownDescriptionProtocol {
  var sectionTitle: String {
    .newLine + "## \(name)"
  }

  var markdownDescription: String {
    "- [\(name)](#\(path))"
  }

}

// MARK: - Comparable

extension Group: Comparable {
  static func < (lhs: Group, rhs: Group) -> Bool {
    lhs.name < rhs.name
  }

  static func == (lhs: Group, rhs: Group) -> Bool {
    lhs.name == rhs.name
  }

}
