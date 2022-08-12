// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Model",
    platforms: [.iOS(.v16)],
    products: [
        .library(
            name: "Model",
            targets: ["Model"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "Model",
            dependencies: [],
            path: "Sources",
            swiftSettings: [
                .unsafeFlags(["-Xfrontend", "-strict-concurrency=complete"])
            ]
        ),
        .testTarget(
            name: "ModelTests",
            dependencies: ["Model"],
            path: "Tests"
        ),
    ]
)
