// 
//  MIT License
//  Copyright (c) 2020 Raycast. All rights reserved.
// 

import ArgumentParser
import CollectorKit

extension CollectorCommand {
    
    struct ValidateScripts: ParsableCommand {
        
        static var configuration = CommandConfiguration(
            commandName: "validate",
            abstract: "Validate all scripts installed or one specified by the user"
        )
        
        func run() throws {
            print("To be implemented")
        }
        
    }
    
}
