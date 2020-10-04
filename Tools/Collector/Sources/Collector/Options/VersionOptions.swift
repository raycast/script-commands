// 
//  MIT License
//  Copyright (c) 2020 Raycast Technologies Ltd. All rights reserved.
// 

import ArgumentParser

struct VersionOptions: ParsableArguments {
    @Flag(name: .shortAndLong, help: "Print the version and exit")
    var version: Bool = false
    
    func validate() throws {
        if version {
            print("Raycast Collector Tool")
            print("Current version: 0.1")
            throw ExitCode.success
        }
    }
}
