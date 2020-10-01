// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "collector",
    dependencies: [
        .package(
            url: "https://github.com/apple/swift-tools-support-core.git", 
            .branch("master")
        ),
    ],
    targets: [
        .target(
            name: "Collector",
            dependencies: [
                "CollectorKit",
                .product(name: "SwiftToolsSupport-auto", package: "swift-tools-support-core")        
            ]
        ),
        .target(
            name: "CollectorKit",
            dependencies: [
                .product(name: "SwiftToolsSupport-auto", package: "swift-tools-support-core")
            ]
        ),
        .testTarget(
            name: "CollectorTests",
            dependencies: ["Collector"]),
    ]
)
