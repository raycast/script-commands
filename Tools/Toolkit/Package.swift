// swift-tools-version:5.3

import PackageDescription

let package = Package(
  name: "toolkit",
  platforms: [
    .macOS(.v11),
  ],
  dependencies: [
    .package(
      url: "https://github.com/apple/swift-argument-parser.git",
      .upToNextMinor(from: "1.0.0")
    ),
  ],
  targets: [
    .target(
      name: "Toolkit",
      dependencies: [
        "ToolkitLibrary",
        .product(name: "ArgumentParser", package: "swift-argument-parser"),
      ]
    ),
    .target(
      name: "ToolkitLibrary",
      dependencies: [],
    ),
    .testTarget(
      name: "ToolkitLibraryTests",
      dependencies: ["ToolkitLibrary"]),
  ]
)
