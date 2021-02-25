//
//  MIT License
//  Copyright (c) 2020-2021 Raycast. All rights reserved.
//

import ArgumentParser
import ToolkitLibrary
import TSCBasic

extension ToolkitCommand {
  struct SetExecutable: ParsableCommand {
    static var configuration = CommandConfiguration(
      abstract: "Set file mode \"executable\" to Script Commands"
    )

    @Argument(help: "Path of the Raycast extensions folder.\n")
    var path: String = "./commands"

    func run() throws {
      let fileSystem = TSCBasic.localFileSystem

      do {
        let toolkit = Toolkit(
          path: fileSystem.absolutePath(for: path)
        )

        try toolkit.setScriptCommandsAsExecutable()
      } catch {
        Toolkit.raycastDescription()
        Console.shared.writeRed("Error: \(error)")
      }
    }
  }
}
