//
//  MIT License
//  Copyright (c) 2020 Raycast. All rights reserved.
//

import Foundation
import TSCBasic

extension Toolkit {
  
  public func report(type: ReportType) throws {
    guard fileSystem.exists(extensionsAbsolutePath) else {
      throw Error.extensionsFolderNotFound(extensionsAbsolutePath.pathString)
    }
    
    var data = RaycastData()
    
    try readFolderContent(
      path: extensionsAbsolutePath,
      parentGroups: &data.groups,
      ignoreFilesInDir: true
    )
    
    let report = Report(
      data: data,
      type: type
    )
    
    report.showResult()
  }
}

