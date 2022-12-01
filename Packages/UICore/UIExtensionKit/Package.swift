// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "UIExtensionKit",
    products: [
        .library(name: "UIExtensionKit", targets: ["UIExtensionKit"]),
    ],
    targets: [
        .target(name: "UIExtensionKit"),
        .testTarget(
            name: "UIExtensionKitTests",
            dependencies: ["UIExtensionKit"]),
    ]
)
