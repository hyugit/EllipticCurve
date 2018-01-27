// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "EllipticCurve",
    products: [
        .library(name: "EllipticCurve", targets: ["EllipticCurve"]),
    ],
    dependencies: [
        .package(url: "https://github.com/mryu87/UInt256.git", from: "0.2.0"),
    ],
    targets: [
        .target(
            name: "EllipticCurve",
            dependencies: ["UInt256"],
            path: "Sources"),
    ]
)
