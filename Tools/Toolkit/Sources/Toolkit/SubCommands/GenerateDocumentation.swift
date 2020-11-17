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

    @Argument(help: "Path of the Raycast extensions folder.\n")
    var path: String = "./commands"

    @Argument(help: "Output file name for the Markdown documentation.\n")
    var outputMarkdownFilename: String = "README.md"

    @Argument(help: "Output file name for the Markdown documentation.\n")
    var outputJSONFilename: String = "extensions.json"

    func run() throws {
      let fileSystem = TSCBasic.localFileSystem

      do {
        let toolkit = Toolkit(
          path: fileSystem.absolutePath(for: path)
        )

        try toolkit.generateDocumentation(
          outputJSONFilename: outputJSONFilename,
          outputMarkdownFilename: outputMarkdownFilename
        )

        Toolkit.raycastDescription()
        Console.shared.writeGreen("Documents generated!")
      } catch {
        Toolkit.raycastDescription()
        Console.shared.writeRed("Error: \(error)")
      }
    }
  }
}
