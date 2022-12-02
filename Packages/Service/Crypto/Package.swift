// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Crypto",
    platforms: [
        .macOS(.v10_13),
        .iOS(.v11),
        .tvOS(.v11),
        .watchOS(.v4),
    ],
    products: [
        .library(name: "Crypto", targets: ["Crypto"]),
    ],
    dependencies: [
        .package(url: "https://github.com/krzyzanowskim/CryptoSwift.git", from: "1.5.1"),
    ],
    targets: [
        .target(name: "Crypto", dependencies: [
            .product(name: "CryptoSwift", package: "CryptoSwift"),
        ]),
        .testTarget(name: "CryptoTests", dependencies: [
            .target(name: "Crypto"),
        ]),
    ]
)
