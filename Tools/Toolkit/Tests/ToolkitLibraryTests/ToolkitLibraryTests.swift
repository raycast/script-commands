//
//  MIT License
//  Copyright (c) 2020-2021 Raycast. All rights reserved.
//

import XCTest
import class Foundation.Bundle

final class ToolkitLibraryTests: XCTestCase {
  func testExample() throws {
    let fooBinary = productsDirectory.appendingPathComponent("toolkit")

    let process = Process()
    process.executableURL = fooBinary

    let pipe = Pipe()
    process.standardOutput = pipe

    try process.run()
    process.waitUntilExit()

    let data = pipe.fileHandleForReading.readDataToEndOfFile()
    let output = String(data: data, encoding: .utf8)

    XCTAssertEqual(output, "OVERVIEW: A tool to generate automatized documentation\n\nUSAGE: toolkit <subcommand>\n\nOPTIONS:\n  -h, --help              Show help information.\n\nSUBCOMMANDS:\n  generate-documentation  Generate the documentation in JSON and Markdown format\n  version                 Print the current Toolkit version\n\n  See \'toolkit help <subcommand>\' for detailed help.\n")
  }

  /// Returns path to the built products directory.
  var productsDirectory: URL {
    #if os(macOS)
    for bundle in Bundle.allBundles where bundle.bundlePath.hasSuffix(".xctest") {
      return bundle.bundleURL.deletingLastPathComponent()
    }
    fatalError("couldn't find the products directory")
    #else
    return Bundle.main.bundleURL
    #endif
  }

  static var allTests = [
    ("testExample", testExample),
  ]
}
