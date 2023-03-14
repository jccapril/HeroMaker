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
        .package(url: "https://github.com/jccapril/TZImagePickerController.git", from: "2.0.1")
    ],
    targets: [
        .target(name: "UIDialog", dependencies: [
            .product(name: "PopupDialog", package: "PopupDialog"),
            .product(name: "TZImagePickerController", package: "TZImagePickerController")
        ]),
        .testTarget(
            name: "UIDialogTests",
            dependencies: ["UIDialog"]),
    ]
)
