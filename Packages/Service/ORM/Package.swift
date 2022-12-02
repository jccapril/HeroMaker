// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ORM",
    products: [
        .library(name: "ORM", targets: ["ORM"]),
    ],
    dependencies: [
        .package(url: "https://github.com/realm/realm-swift.git", from: "10.28.2"),
    ],
    targets: [
        .target(name: "ORM", dependencies: [
            .product(name: "Realm", package: "realm-swift"),
            .product(name: "RealmSwift", package: "realm-swift"),
        ]),
        .testTarget(name: "ORMTests", dependencies: [
            .target(name: "ORM"),
        ]),
    ]
)
