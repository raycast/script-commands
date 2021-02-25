//
//  MIT License
//  Copyright (c) 2020-2021 Raycast. All rights reserved.
//

import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
  return [
    testCase(ToolkitLibraryTests.allTests),
  ]
}
#endif
