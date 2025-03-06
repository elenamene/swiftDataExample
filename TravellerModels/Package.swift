// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "TravellerModels",
    platforms: [
        .iOS(.v18)
    ],
    products: [
        .library(
            name: "TravellerModels",
            targets: ["TravellerModels"]
        )
    ],
    dependencies: [],
    targets: [
        .target(name: "TravellerModels")
    ]
)
