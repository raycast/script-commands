// 
//  MIT License
//  Copyright (c) 2020 Raycast Technologies Ltd. All rights reserved.
// 

import ArgumentParser
import CollectorKit
import TSCBasic

extension CollectorCommand {
    
    struct GenerateDocumentation: ParsableCommand {
        
        static var configuration = CommandConfiguration(
            abstract: "Generate the documentation in JSON and Markdown format"
        )
        
        @Argument(help: "Path of the Raycast extensions folder. [Default path: ../../]")
        var path: String = "../../"
        
        func run() throws {
            let fileSystem = TSCBasic.localFileSystem
            
            do {
                let collector = Collector(
                    path: fileSystem.absolutePath(for: self.path)
                )
                
                try collector.generateDocumentation()
            }
            catch {
                print("Error: \(error.localizedDescription)")
            }

        }

    }
}

