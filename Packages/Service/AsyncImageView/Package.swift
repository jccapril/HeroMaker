// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AsyncImageView",
    platforms: [.iOS(.v12), .macOS(.v10_14), .tvOS(.v12), .watchOS(.v5)],
    products: [
        .library(name: "AsyncImageView", targets: ["AsyncImageView"]),
    ],
    dependencies: [
        .package(url: "https://github.com/onevcat/Kingfisher.git", from: "7.3.0"),
    ],
    targets: [
        .target(name: "AsyncImageView", dependencies: [
            .product(name: "Kingfisher", package: "Kingfisher"),
        ]),
        .testTarget(name: "AsyncImageViewTests", dependencies: [
            .target(name: "AsyncImageView"),
        ]),
    ]
)
