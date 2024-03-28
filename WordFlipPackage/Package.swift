// swift-tools-version: 5.7.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "WordFlipPackage",
    defaultLocalization: "rus",
    platforms: [.iOS(.v15)],
    products: [
        .library(
            name: "WordFlipPackage",
            targets: ["WordFlipPackage"]),
    ],
    dependencies: [
        .package(
            url: "https://github.com/firebase/firebase-ios-sdk.git",
            from: "10.0.0"),
    ],
    targets: [
        .target(
            name: "WordFlipPackage",
            dependencies: [
                "EntityModule",
                "ProfilePackage",
                "Authentication",
                "NavigationModule",
                "MainView",
                "Builder",
                .product(
                    name: "FirebaseAuth",
                    package: "firebase-ios-sdk"
                ),
                .product(
                    name: "FirebaseDatabase",
                    package: "firebase-ios-sdk"
                ),
                .product(
                    name: "FirebaseStorage",
                    package: "firebase-ios-sdk"
                ),
                .product(
                    name: "FirebaseFirestore",
                    package: "firebase-ios-sdk"
                ),
            ]
        ),
        .target(
            name: "ProfilePackage",
            dependencies: ["SystemDesign",
                          "Authentication"]
        ),
        .target(
            name: "Models",
            dependencies: []
        ),
        .target(
            name: "SystemDesign",
            dependencies: []
        ),
        .target(
            name: "NavigationModule",
            dependencies: []),
        .target(
            name: "MainView",
            dependencies: ["SystemDesign"]),
        .target(
            name: "Authentication",
            dependencies: [
                "SystemDesign",
                .product(
                    name: "FirebaseAuth",
                    package: "firebase-ios-sdk"
                ),
                .product(
                    name: "FirebaseFirestore",
                    package: "firebase-ios-sdk"
                ),
                .product(
                    name: "FirebaseDatabase",
                    package: "firebase-ios-sdk"
                ),
            ]
        ),
        .target(name: "Builder",
                dependencies: [
                    "Authentication",
                    "EntityModule",
                    "MainView",
                    "Models",
                    "NavigationModule",
                    "ProfilePackage",
                    "SystemDesign",
                ]
               ),
        .target(
            name: "EntityModule",
            dependencies: [
                "SystemDesign",
                "Models",
            ]
        ),
        .testTarget(
            name: "WordFlipPackageTests",
            dependencies: ["WordFlipPackage"]
        ),
    ]
)
