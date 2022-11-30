// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "RestfulClient",
    products: [
        .library(name: "RestfulClient", targets: ["RestfulClient"]),
    ],
    dependencies: [
        .package(url: "https://github.com/swift-server/async-http-client.git", from: "1.11.1"),
    ],
    targets: [
        .target(name: "RestfulClient", dependencies: [
            .product(name: "AsyncHTTPClient", package: "async-http-client"),
        ]),
        .testTarget(
            name: "RestfulClientTests",
            dependencies: ["RestfulClient"]),
    ]
)
