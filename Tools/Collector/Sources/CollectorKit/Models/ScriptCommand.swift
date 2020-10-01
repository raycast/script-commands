// 
//  MIT License
//  Copyright (c) 2020 Raycast Technologies Ltd. All rights reserved.
// 

import Foundation

typealias ScriptCommands = [ScriptCommand]

struct ScriptCommand: Codable {
    enum Mode: String, Codable {
        case fullOutput
        case compact
        case silent
    }
    
    let schemaVersion: Int
    let title: String
    let mode: Mode?
    var packageName: String?
    let icon: String?
    let author: String?
}
