// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "UILayout",
    products: [
        .library(
            name: "UILayout",
            targets: ["UILayout"]),
    ],
    dependencies: [
        .package(url: "https://github.com/layoutBox/PinLayout.git", from: "1.10.3"),
        .package(url: "https://github.com/SnapKit/SnapKit.git", from: "5.0.0"),
    ],
    targets: [
        .target(name: "UILayout", dependencies: [
            .product(name: "PinLayout", package: "PinLayout"),
            .product(name: "SnapKit", package: "SnapKit"),
        ]),
        .testTarget(
            name: "UILayoutTests",
            dependencies: ["UILayout"]),
    ]
)
