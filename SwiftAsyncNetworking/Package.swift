// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftAsyncNetworking",
    platforms: [
        .macOS(.v12),
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "SwiftAsyncNetworking",
            targets: ["SwiftAsyncNetworking"]),
    ],
    targets: [
        .target(
            name: "SwiftAsyncNetworking"),
        .testTarget(
            name: "SwiftAsyncNetworkingTests",
            dependencies: ["SwiftAsyncNetworking"]),
    ]
)
