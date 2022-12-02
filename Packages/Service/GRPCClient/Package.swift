// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "GRPCClient",
    products: [
        .library(name: "GRPCClient", targets: ["GRPCClient"]),
    ],
    dependencies: [
        .package(url: "https://github.com/grpc/grpc-swift.git", from: "1.7.3"),
    ],
    targets: [
        .target(name: "GRPCClient", dependencies: [
            .product(name: "GRPC", package: "grpc-swift"),
        ]),
        .testTarget(name: "GRPCClientTests", dependencies: [
            .target(name: "GRPCClient"),
        ]),
    ]
)
