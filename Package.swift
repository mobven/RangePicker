// swift-tools-version: 5.8

import PackageDescription

let package = Package(
    name: "RangePicker",
    platforms: [.iOS(.v11)],
    products: [
        .library(
            name: "RangePicker",
            targets: ["RangePicker"]
        )
    ],
    dependencies: [],
    targets: [
        .target(
            name: "RangePicker",
            dependencies: []
        ),
        .testTarget(
            name: "RangePickerTests",
            dependencies: ["RangePicker"]
        )
    ]
)
