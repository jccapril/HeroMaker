// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AppLifeCycle",
    products: [
        .library(name: "AppLifeCycle", targets: ["AppLifeCycle"]),
    ],
    targets: [
        .target(name: "AppLifeCycle"),
        .testTarget(
            name: "AppLifeCycleTests",
            dependencies: ["AppLifeCycle"]),
    ]
)
