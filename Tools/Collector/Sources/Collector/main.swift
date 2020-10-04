// 
//  MIT License
//  Copyright (c) 2020 Raycast Technologies Ltd. All rights reserved.
// 

import Foundation

import ArgumentParser
import CollectorKit
import TSCBasic

struct CollectorCommand: ParsableCommand {
    
    static var configuration = CommandConfiguration(
        commandName: "collector",
        abstract: "A tool to generate automatized documentation",
        subcommands: [
            CreateScript.self,
            GenerateDocumentation.self,
            ValidateScripts.self
        ]
    )
    
    @OptionGroup
    var versionOptions: VersionOptions
    
}

CollectorCommand.main()
