// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftKit",
    products: [
        .library(name: "SwiftKit", targets: ["SwiftKit"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-collections.git", from: "1.0.2"),
        .package(url: "https://github.com/apple/swift-numerics", from: "1.0.2"),
        .package(url: "https://github.com/apple/swift-algorithms", from: "1.0.0"),
        .package(url: "https://github.com/apple/swift-atomics.git", from: "1.0.2"),
    ],
    targets: [
        .target(name: "SwiftKit", dependencies: [
            .product(name: "Collections", package: "swift-collections"),
            .product(name: "DequeModule", package: "swift-collections"),
            .product(name: "OrderedCollections", package: "swift-collections"),
            .product(name: "Numerics", package: "swift-numerics"),
            .product(name: "Algorithms", package: "swift-algorithms"),
            .product(name: "Atomics", package: "swift-atomics"),
        ]),
        .testTarget(name: "SwiftKitTests", dependencies: [
            .target(name: "SwiftKit"),
        ]),
    ]
)

