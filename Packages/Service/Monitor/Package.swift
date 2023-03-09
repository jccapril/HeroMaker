// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Monitor",
    products: [
        .library(
            name: "Monitor",
            targets: ["Monitor"]),
    ],
    dependencies: [
         .package(url: "https://github.com/ashleymills/Reachability.swift.git", from: "5.0.0"),
    ],
    targets: [
        .target(
            name: "Monitor",
            dependencies: [
                .product(name: "Reachability", package: "Reachability.swift"),
            ]),
        .testTarget(
            name: "MonitorTests",
            dependencies: ["Monitor"]),
    ]
)
