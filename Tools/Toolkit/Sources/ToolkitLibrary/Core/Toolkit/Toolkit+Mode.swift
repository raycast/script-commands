//
//  MIT License
//  Copyright (c) 2020-2021 Raycast. All rights reserved.
//

import Foundation
import TSCBasic

extension Toolkit {
  public func setScriptCommandsAsExecutable() throws {
    var data = RaycastData()

    try readFolderContent(
      path: dataManager.extensionsPath,
      parentGroups: &data.groups,
      ignoreFilesInDir: true
    )

    var scriptCommands = ScriptCommands()

    data.groups.forEach { group in
      filter(
        for: group,
        scriptCommands: &scriptCommands
      )
    }

    let rawCount = scriptCommands.count
    var newModeCount = 0

    scriptCommands.sorted().forEach { scriptCommand in
      let filePath = dataManager.extensionsPath.appending(RelativePath(scriptCommand.fullPath))

      do {
        try fileSystem.chmod(.executable, path: filePath)
        newModeCount += 1
      } catch {
        return
      }
    }

    let console = Console(noColor: false)

    Toolkit.raycastDescription()

    if newModeCount > 0 {
      console.write("Result:", endLine: false)
      console.writeYellow(" \(newModeCount) ", bold: true, endLine: false)
      console.write("of", endLine: false)
      console.writeGreen(" \(rawCount) ", bold: true, endLine: false)
      console.write("Script Commands was set as \"executable\".")
    } else {
      console.write("✅ Nothing to be done.")
    }
  }
}

private extension Toolkit {
  func filter(for group: Group, scriptCommands: inout ScriptCommands) {
    if group.scriptCommands.isEmpty == false {
      for scriptCommand in group.scriptCommands where scriptCommand.isExecutable == false {
        scriptCommands.append(scriptCommand)
      }
    }

    if let subGroups = group.subGroups {
      for subGroup in subGroups {
        filter(
          for: subGroup,
          scriptCommands: &scriptCommands
        )
      }
    }
  }
}
