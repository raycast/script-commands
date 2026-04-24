//
// MIT License
// Copyright (c) 2020-2026 Raycast. All rights reserved.
//

import XCTest
@testable import ToolkitLibrary

final class ScriptCommandPlatformTests: XCTestCase {
  // MARK: - Raw Values

  func testMacOSRawValue() {
    XCTAssertEqual(ScriptCommand.Platform.macOS.rawValue, "macos")
  }

  func testWindowsRawValue() {
    XCTAssertEqual(ScriptCommand.Platform.windows.rawValue, "windows")
  }

  // MARK: - Initialisation from raw value

  func testInitFromLowercasedRawValue() {
    XCTAssertEqual(ScriptCommand.Platform(rawValue: "macos"), .macOS)
    XCTAssertEqual(ScriptCommand.Platform(rawValue: "windows"), .windows)
  }

  func testInitFromNonLowercasedRawValueFails() {
    // The keyValue parser lowercases the platform string before decoding,
    // so uppercase raw values should never reach the decoder — but the enum
    // itself must NOT silently accept them.
    XCTAssertNil(ScriptCommand.Platform(rawValue: "macOS"))
    XCTAssertNil(ScriptCommand.Platform(rawValue: "Windows"))
    XCTAssertNil(ScriptCommand.Platform(rawValue: "MACOS"))
  }

  // MARK: - Markdown description

  func testMacOSMarkdownDescription() {
    XCTAssertEqual(ScriptCommand.Platform.macOS.markdownDescription, "macOS")
  }

  func testWindowsMarkdownDescription() {
    XCTAssertEqual(ScriptCommand.Platform.windows.markdownDescription, "Windows")
  }

  func testNilPlatformDefaultsToMacOSInMarkdown() {
    // ScriptCommand.markdownDescription uses `(platform ?? .macOS).markdownDescription`
    let platform: ScriptCommand.Platform? = nil
    XCTAssertEqual((platform ?? .macOS).markdownDescription, "macOS")
  }

  // MARK: - Codable round-trip

  func testCodableRoundTrip() throws {
    let encoder = JSONEncoder()
    let decoder = JSONDecoder()

    for platform in [ScriptCommand.Platform.macOS, .windows] {
      let data = try encoder.encode(platform)
      let decoded = try decoder.decode(ScriptCommand.Platform.self, from: data)
      XCTAssertEqual(decoded, platform)
    }
  }

  // MARK: - ScriptCommand JSON decoding with platform field

  func testScriptCommandDecodesWithMacOSPlatform() throws {
    let command = try makeScriptCommand(platform: "macos")
    XCTAssertEqual(command.platform, .macOS)
  }

  func testScriptCommandDecodesWithWindowsPlatform() throws {
    let command = try makeScriptCommand(platform: "windows")
    XCTAssertEqual(command.platform, .windows)
  }

  func testScriptCommandDecodesWithoutPlatform() throws {
    let command = try makeScriptCommand(platform: nil)
    XCTAssertNil(command.platform)
  }
}

// MARK: - Helpers

private extension ScriptCommandPlatformTests {
  func makeScriptCommand(platform: String?) throws -> ScriptCommand {
    var json = """
    {
      "schemaVersion": 1,
      "title": "Test Command",
      "language": "bash",
      "isTemplate": false,
      "hasArguments": false,
      "path": "system/",
      "filename": "test.sh",
      "createdAt": "2024-01-01T00:00:00+0000",
      "updatedAt": "2024-01-01T00:00:00+0000"
    """

    if let platform {
      json += ",\n  \"platform\": \"\(platform)\""
    }

    json += "\n}"

    let data = try XCTUnwrap(json.data(using: .utf8))
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .iso8601
    return try decoder.decode(ScriptCommand.self, from: data)
  }
}
