// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "WeakDelegate",
    products: [
        .library(name: "WeakDelegate", targets: ["WeakDelegate"]),
    ],
    targets: [
        .target(name: "WeakDelegate"),
        .testTarget(
            name: "WeakDelegateTests",
            dependencies: ["WeakDelegate"]),
    ]
)
