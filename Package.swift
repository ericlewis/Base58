// swift-tools-version:5.5

import PackageDescription

let package = Package(
    name: "Base58",
    platforms: [
        .macOS(.v10_15),
        .iOS(.v13)
    ],
    products: [
        .library(
            name: "Base58",
            targets: ["Base58"]
        )
    ],
    dependencies: [
        .package(
            url: "https://github.com/attaswift/BigInt.git",
            .upToNextMajor(from: "5.3.0")
        )
    ],
    targets: [
        .target(
            name: "Base58",
            dependencies: ["BigInt"]
        ),
        .testTarget(
            name: "Base58Tests",
            dependencies: ["Base58"]
        )
    ]
)
