// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SuperSegurosSDKIOS",
    platforms: [
        .iOS(.v13)
    ],
    products: [
 
        .library(
            name: "SuperSegurosSDKIOS",
            targets: ["SuperSegurosSDKIOS"]),
    ],
    dependencies: [
        .package(url: "https://github.com/Alamofire/Alamofire.git", exact: "5.9.1"),
        .package(url: "https://github.com/Juanpe/SkeletonView.git", exact: "1.31.0"),
        .package(url: "https://github.com/hackiftekhar/IQKeyboardManager.git", exact: "7.0.3")
    ],
    targets: [
        .target(
            name: "SuperSegurosSDKIOS",
            dependencies: [
                .product(name: "Alamofire", package: "Alamofire"),
                .product(name: "SkeletonView", package: "SkeletonView"),
                .product(name: "IQKeyboardManagerSwift", package: "IQKeyboardManager")
            ]
        ),
        .testTarget(
            name: "SuperSegurosSDKIOSTests",
            dependencies: ["SuperSegurosSDKIOS"]
        ),
    ]
)
