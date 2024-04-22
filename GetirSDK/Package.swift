// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "GetirSDK",
    platforms: [
        .macOS(.v12),
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "GetirSDK",
            targets: ["GetirSDK"]),
    ], dependencies: [
        .package(path: "../SwiftAsyncNetworking")],
    targets: [
        .target(
            name: "GetirSDK",
        dependencies: ["SwiftAsyncNetworking"]),
        .testTarget(
            name: "GetirSDKTests",
            dependencies: ["GetirSDK"]),
    ]
)
