// swift-tools-version:5.9

//
// This source file is part of the SpeziLocation open source project
// 
// SPDX-FileCopyrightText: 2022 Stanford University and the project authors (see CONTRIBUTORS.md)
// 
// SPDX-License-Identifier: MIT
//

import PackageDescription


let package = Package(
    name: "SpeziLocation",
    platforms: [
        .iOS(.v17)
    ],
    products: [
        .library(name: "SpeziLocation", targets: ["SpeziLocation"])
    ],
    dependencies: [
        .package(url: "https://github.com/StanfordSpezi/Spezi", from: "1.8.0")
    ],
    targets: [
        .target(
            name: "SpeziLocation",
            dependencies: [
                 .product(name: "Spezi", package: "Spezi")
            ]
        ),
        .testTarget(
            name: "SpeziLocationTests",
            dependencies: [
                .target(name: "SpeziLocation")
            ]
        )
    ]
)
