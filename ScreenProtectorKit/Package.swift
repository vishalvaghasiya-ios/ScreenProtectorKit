// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ScreenProtectorKit",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "ScreenProtectorKit",
            targets: ["ScreenProtectorKit"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "ScreenProtectorKit",
            dependencies: [],
            path: "Sources/ScreenProtectorKit"),
        .testTarget(
            name: "ScreenProtectorKitTests",
            dependencies: ["ScreenProtectorKit"]),
    ]
)
