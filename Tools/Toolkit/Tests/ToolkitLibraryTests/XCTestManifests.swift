//
// MIT License
// Copyright (c) 2020-2026 Raycast. All rights reserved.
//

import XCTest

#if !canImport(ObjectiveC)
  public func allTests() -> [XCTestCaseEntry] {
    [
      testCase(ToolkitLibraryTests.allTests),
    ]
  }
#endif
