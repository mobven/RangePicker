// swift-tools-version: 5.8

import PackageDescription

let package = Package(
    name: "RangePickerView",
    platforms: [.iOS(.v11)],
    products: [
        .library(
            name: "RangePickerView",
            targets: ["RangePickerView"]
        )
    ],
    dependencies: [],
    targets: [
        .target(
            name: "RangePickerView",
            dependencies: []
        ),
        .testTarget(
            name: "RangePickerViewTests",
            dependencies: ["RangePickerView"]
        )
    ]
)
