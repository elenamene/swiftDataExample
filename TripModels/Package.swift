// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "TripModels",
    platforms: [
        .iOS(.v18)
    ],
    products: [
        .library(
            name: "TripModels",
            targets: ["TripModels"]
        )
    ],
    dependencies: [
        .package(name: "TravellerModels", path: "../TravellerModels")
    ],
    targets: [
        .target(
            name: "TripModels",
            dependencies: [
                "TravellerModels"
            ]
        )
    ]
)
