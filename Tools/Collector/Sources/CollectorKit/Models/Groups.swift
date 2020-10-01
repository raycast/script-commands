// 
//  MIT License
//  Copyright (c) 2020 Raycast Technologies Ltd. All rights reserved.
// 

import Foundation

typealias Groups = [Group]

struct Group: Codable {
    let name: String
    let scriptCommands: ScriptCommands
}
