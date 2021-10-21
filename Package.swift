// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "GACalc",
    products: [
        .library(name: "GACalc", targets: ["GACalc"])
    ],
    dependencies: [],
    targets: [
        .target(name: "GACalc", dependencies: []),
        .testTarget(name: "GACalcTests", dependencies: ["GACalc"])
    ]
)
