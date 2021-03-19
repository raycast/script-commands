//
//  MIT License
//  Copyright (c) 2020-2021 Raycast. All rights reserved.
//

import Foundation
import TSCBasic

extension Toolkit {
  public func generateDocumentation(outputJSONFilename: String, outputMarkdownFilename: String) throws {
    dataManager.loadContent()

    try readFolderContent(
      path: dataManager.extensionsPath,
      parentGroups: &dataManager.data.groups,
      ignoreFilesInDir: true
    )

    let documentation = Documentation(
      path: dataManager.extensionsPath,
      jsonFilename: outputJSONFilename,
      markdownFilename: outputMarkdownFilename
    )

    try documentation.generateDocuments(
      for: dataManager.data
    )
  }
}
