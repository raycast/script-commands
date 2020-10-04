// 
//  MIT License
//  Copyright (c) 2020 Raycast. All rights reserved.
// 

import ArgumentParser
import CollectorKit

extension CollectorCommand {

    struct CreateScript: ParsableCommand {

        static var configuration = CommandConfiguration(
            commandName: "create",
            abstract: "Create a placeholder for your script"
        )

        func run() throws {
            print("To be implemented")
        }

    }

}
