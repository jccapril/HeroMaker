// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "UIDialog",
    platforms: [.iOS(.v12)],
    products: [
        .library(
            name: "UIDialog",
            targets: ["UIDialog"]),
    ],
    dependencies: [
        .package(url: "https://github.com/Orderella/PopupDialog.git", branch: "master"),
    ],
    targets: [
        .target(name: "UIDialog", dependencies: [
            .product(name: "PopupDialog", package: "PopupDialog"),
        ]),
        .testTarget(
            name: "UIDialogTests",
            dependencies: ["UIDialog"]),
    ]
)
