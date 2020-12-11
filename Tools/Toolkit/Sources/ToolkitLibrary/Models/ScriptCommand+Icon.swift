//
//  MIT License
//  Copyright (c) 2020 Raycast. All rights reserved.
//

import Foundation

extension ScriptCommand {
  
  struct Icon: Codable {
    let light: String?
    let dark: String?
    
    init(from decoder: Decoder) throws {
      let container = try decoder.container(keyedBy: InputCodingKeys.self)
      
      light = try container.decodeIfPresent(String.self, forKey: .icon)
      dark = try container.decodeIfPresent(String.self, forKey: .iconDark)
    }
    
    func encode(to encoder: Encoder) throws {
      var container = encoder.container(keyedBy: OutputCodingKeys.self)
      
      try container.encode(light, forKey: .light)
      try container.encode(dark, forKey: .dark)
    }
  }
}

extension ScriptCommand.Icon {
  
  enum InputCodingKeys: String, CodingKey {
    case icon = "icon"
    case iconDark = "iconDark"
  }
  
  enum OutputCodingKeys: String, CodingKey {
    case light
    case dark
  }
}
