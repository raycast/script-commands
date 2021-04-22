//
//  MIT License
//  Copyright (c) 2020-2021 Raycast. All rights reserved.
//

import Foundation
import TSCBasic

extension Toolkit {
  public func report(type: ReportType, noColor: Bool) throws {
    try readFolderContent(
      path: dataManager.extensionsPath,
      parentGroups: &dataManager.data.groups,
      ignoreFilesInDir: true
    )

    let report = Report(
      data: dataManager.data,
      type: type,
      noColor: noColor
    )

    report.showResult()
  }
}
