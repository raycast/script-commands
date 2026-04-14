// swift-tools-version:6.0

import PackageDescription

let package = Package(
  name: "toolkit",
  platforms: [
    .macOS(.v13),
  ],
  dependencies: [
    .package(
      url: "https://github.com/apple/swift-argument-parser.git",
      .upToNextMajor(from: "1.5.0"),
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
