// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "LoggerPool",
    products: [
        .library(name: "LoggerPool", targets: ["LoggerPool"]),
    ],
    dependencies: [
        .package(name: "Locks", path: "./Locks"),
        .package(url: "https://github.com/jccapril/Senna.git", from: "1.0.0"),
    ],
    targets: [
        .target(
            name: "LoggerPool",dependencies: [
                .product(name: "Senna", package: "Senna"),
                .product(name: "Locks", package: "Locks"),
            ]),
        .testTarget(
            name: "LoggerPoolTests",
            dependencies: ["LoggerPool"]),
    ]
)
