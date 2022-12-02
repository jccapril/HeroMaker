// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "UIHierarchy",
    products: [
        .library(name: "UIHierarchy", targets: ["UIHierarchy"]),
    ],
    dependencies: [
        .package(url: "https://github.com/QMUI/LookinServer.git", from: "1.0.6"),
    ],
    targets: [
        .target(name: "UIHierarchy", dependencies: [
            .product(name: "LookinServer", package: "LookinServer"),
        ]),
        .testTarget(name: "UIHierarchyTests", dependencies: [
            .target(name: "UIHierarchy"),
        ]),
    ]
)
