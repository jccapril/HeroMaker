// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "UIWebKit",
    products: [
        .library(name: "UIWebKit", targets: ["UIWebKit"]),
    ],
    targets: [
        .target(name: "UIWebKit"),
        .testTarget(name: "UIWebKitTests", dependencies: [
            .target(name: "UIWebKit"),
        ]),
    ]
)
