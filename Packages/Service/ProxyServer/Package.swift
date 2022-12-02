// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ProxyServer",
    platforms: [
        .macOS(.v10_15),
        .iOS(.v13),
        .tvOS(.v13),
    ],
    products: [
        .library(name: "ProxyServer", targets: ["ProxyServer"]),
    ],
    dependencies: [
        .package(url: "https://github.com/hummingbird-project/hummingbird-core", from: "0.13.5"),
        .package(url: "https://github.com/swift-server/swift-service-lifecycle.git", branch: "main"),
    ],
    targets: [
        .target(name: "ProxyServer", dependencies: [
            .product(name: "HummingbirdCore", package: "hummingbird-core"),
            .product(name: "HummingbirdTLS", package: "hummingbird-core"),
            .product(name: "Lifecycle", package: "swift-service-lifecycle"),
            .product(name: "LifecycleNIOCompat", package: "swift-service-lifecycle"),
        ]),
        .testTarget(
            name: "ProxyServerTests",
            dependencies: ["ProxyServer"]),
    ]
)
