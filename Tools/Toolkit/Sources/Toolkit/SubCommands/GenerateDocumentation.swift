//
//  MIT License
//  Copyright (c) 2020 Raycast. All rights reserved.
//

import ArgumentParser
import ToolkitLibrary
import TSCBasic

extension ToolkitCommand {

  struct GenerateDocumentation: ParsableCommand {

    static var configuration = CommandConfiguration(
      abstract: "Generate the documentation in JSON and Markdown format"
    )

    @Argument(help: "Path of the Raycast extensions folder. [Default path: ../../]")
    var path: String = "../../"

    func run() throws {
      let fileSystem = TSCBasic.localFileSystem

      do {
        let toolkit = Toolkit(
          path: fileSystem.absolutePath(for: self.path)
        )

        try toolkit.generateDocumentation()
      } catch {
        print("Error: \(error)")
      }

    }

  }
}
