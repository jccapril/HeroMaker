// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "BaseUI",
    products: [
        .library(name: "BaseUI", targets: ["BaseUI"]),
    ],

    targets: [
        .target(name: "BaseUI"),
        .testTarget(
            name: "BaseUITests",
            dependencies: ["BaseUI"]),
    ]
)
