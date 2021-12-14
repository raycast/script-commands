//
//  MIT License
//  Copyright (c) 2020-2021 Raycast. All rights reserved.
//

import Foundation

struct RaycastData: Codable {
  var groups: Groups
  var updatedAt: Date
  var totalScriptCommands: Int
  var metadata: [Metadata]
  var languages: Set<Language.Information>

  var isEmpty: Bool {
    groups.isEmpty
      && totalScriptCommands == 0
      && metadata.isEmpty
  }

  private enum CodingKeys: String, CodingKey {
    case groups
    case updatedAt
    case totalScriptCommands
    case metadata
    case languages
  }

  init() {
    self.groups = .init()
    self.updatedAt = Date()
    self.totalScriptCommands = 0
    self.metadata = []
    self.languages = []
  }

  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)

    groups = try container.decode(Groups.self, forKey: .groups)
    totalScriptCommands = try container.decode(Int.self, forKey: .totalScriptCommands)
    languages = try container.decode(Set<Language.Information>.self, forKey: .languages)

    if let value = try container.decodeIfPresent(String.self, forKey: .updatedAt) {
      let dateFormatter = DateFormatter()
      dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"

      self.updatedAt = dateFormatter.date(from: value) ?? Date()
    } else {
      self.updatedAt = Date()
    }

    if let metadata = try container.decodeIfPresent([Metadata].self, forKey: .metadata) {
      self.metadata = metadata
    } else {
      self.metadata = []
    }
  }
}
