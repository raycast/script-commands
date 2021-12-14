//
//  MIT License
//  Copyright (c) 2020-2021 Raycast. All rights reserved.
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
      self.displayName = language.displayName
      self.icon = language.icon
    }
  }
}

extension Language.Information: Hashable {
  func hash(into hasher: inout Hasher) {
    hasher.combine(name)
  }
}
