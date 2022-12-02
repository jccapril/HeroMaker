// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftAsyncKit",
    platforms: [
        .macOS(.v10_15),
        .iOS(.v13),
        .tvOS(.v13),
        .watchOS(.v6),
    ],
    products: [
        .library(name: "SwiftAsyncKit", targets: ["SwiftAsyncKit"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-async-algorithms", from: "0.0.1"),
    ],
    targets: [
        .target(name: "SwiftAsyncKit", dependencies: [
            .product(name: "AsyncAlgorithms", package: "swift-async-algorithms"),
        ]),
        .testTarget(name: "SwiftAsyncKitTests", dependencies: [
            .target(name: "SwiftAsyncKit"),
        ]),
    ]
)
