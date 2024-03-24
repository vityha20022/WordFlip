// swift-tools-version: 5.8
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
    ],
    targets: [
        .target(
            name: "WordFlipPackage",
            dependencies: ["ProfilePackage", "Router"]),
        .target(
            name: "ProfilePackage",
            dependencies: ["SystemDesign"]),
        .target(
            name: "SystemDesign",
            dependencies: []),
        .target(
            name: "NavigationModule",
            dependencies: []),
        .target(
            name: "MainView",
            dependencies: ["SystemDesign"]),
        .target(
            name: "Router",
            dependencies: ["NavigationModule", "MainView"]),
        .testTarget(
            name: "WordFlipPackageTests",
            dependencies: ["WordFlipPackage"]),
    ]
)
