//
//  MIT License
//  Copyright (c) 2020-2021 Raycast. All rights reserved.
//

import Foundation

typealias Groups = [Group]

struct Group: Codable {
  var name: String
  let path: String
  var readme: String?
  var scriptCommands: ScriptCommands = []
  var subGroups: Groups?
}

// MARK: - MarkdownDescription Protocol

extension Group: MarkdownDescriptionProtocol {
  var sectionTitle: String {
    .newLine + "## \(name)"
  }

  var markdownDescription: String {
    renderTree(for: self, level: 0)
  }

  func renderItem(for group: Group, level: Int = 0) -> String {
    "\(indent: level)- [\(group.name)](#\(group.path))"
  }

  func renderTree(for group: Group, level: Int) -> String {
    var description = String.empty

    if let subGroups = group.subGroups?.sorted() {
      description += renderItem(
        for: group,
        level: level
      )

      for subGroup in subGroups {
        description += renderTree(
          for: subGroup,
          level: level + 1
        )
      }
    } else {
      description += renderItem(
        for: group,
        level: level
      )
    }

    return description
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
