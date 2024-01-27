// swift-tools-version: 5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Sora",
    platforms: [.macOS(.v10_15),
                .iOS(.v13),
                .tvOS(.v13),
                .watchOS(.v6)],
    products: [
        .library(
            name: "Sora",
            targets: ["Sora"]),
    ],
    dependencies: [
        .package(url: "https://github.com/Alamofire/Alamofire.git", from: "5.8.1")
    ],
    targets: [
        .target(
            name: "Sora",
            dependencies: [.product(name: "Alamofire", package: "Alamofire")]),
        .testTarget(
            name: "SoraTests",
            dependencies: ["Sora"])
    ]
)
