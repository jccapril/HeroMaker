// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "BaseUI",
    products: [
        .library(name: "BaseUI", targets: ["BaseUI"]),
    ],
    dependencies: [
        .package(url: "https://github.com/SFSafeSymbols/SFSafeSymbols.git", from: "4.0.0")
    ],
    targets: [
        .target(name: "BaseUI", dependencies: [
            .product(name: "SFSafeSymbols", package: "SFSafeSymbols"),
        ]),
        .testTarget(
            name: "BaseUITests",
            dependencies: ["BaseUI"]),
    ]
)
