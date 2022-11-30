// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Coder",
    products: [
        .library(name: "Coder", targets: ["Coder"]),
    ],
    dependencies: [
        .package(url: "https://github.com/swift-extras/swift-extras-json.git", from: "0.6.0"),
        .package(url: "https://github.com/jverkoey/BinaryCodable.git", from: "0.3.1"),
        .package(url: "https://github.com/jccapril/CodableBetter", from: "1.0.0"),
    ],
    targets: [

        .target(
            name: "Coder",dependencies: [
                .product(name: "ExtrasJSON", package: "swift-extras-json"),
                .product(name: "BinaryCodable", package: "BinaryCodable"),
                .product(name: "CodableBetter", package: "CodableBetter"),
            ]),
        .testTarget(
            name: "CoderTests",
            dependencies: ["Coder"]),
    ]
)
