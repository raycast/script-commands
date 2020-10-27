// swift-tools-version:5.3

import PackageDescription

let package = Package(
  name: "toolkit",
  platforms: [
    .macOS(.v10_14)
  ],
  dependencies: [
    .package(
      url: "https://github.com/apple/swift-tools-support-core.git",
      .upToNextMinor(from: "0.1.11")
    ),
    .package(
      url: "https://github.com/apple/swift-argument-parser.git",
      .upToNextMinor(from: "0.3.0")
    )
  ],
  targets: [
    .target(
      name: "Toolkit",
      dependencies: [
        "ToolkitLibrary",
        .product(name: "SwiftToolsSupport-auto", package: "swift-tools-support-core"),
        .product(name: "ArgumentParser", package: "swift-argument-parser")
      ]
    ),
    .target(
      name: "ToolkitLibrary",
      dependencies: [
        .product(name: "SwiftToolsSupport-auto", package: "swift-tools-support-core")
      ]
    ),
    .testTarget(
      name: "ToolkitLibraryTests",
      dependencies: ["ToolkitLibrary"])
  ]
)
