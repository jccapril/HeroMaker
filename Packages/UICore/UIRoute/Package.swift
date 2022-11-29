// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "UIRoute",
    products: [
        .library(name: "UIRoute", targets: ["UIRoute"]),
    ],
    dependencies: [
        .package(url: "https://github.com/jccapril/URLRoute", from: "1.0.1"),
    ],
    targets: [
        .target(name: "UIRoute", dependencies: [
            .product(name: "URLRoute", package: "URLRoute"),
        ]),
        .testTarget(
            name: "UIRouteTests",
            dependencies: ["UIRoute"]),
    ]
)
