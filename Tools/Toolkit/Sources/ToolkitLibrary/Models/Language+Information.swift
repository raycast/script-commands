//
// MIT License
// Copyright (c) 2020-2026 Raycast. All rights reserved.
//

extension Language {
  typealias Informations = [Information]

  struct Information: Codable {
    let name: String
    let displayName: String
    let icon: String?

    init(name: String) {
      let language = Language(name)

      self.name = language.name
      displayName = language.displayName
      icon = language.icon
    }
  }
}

// MARK: - Language.Information + Hashable

extension Language.Information: Hashable {
  func hash(into hasher: inout Hasher) {
    hasher.combine(name)
  }
}
