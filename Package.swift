// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

typealias PackageDependency = PackageDescription.Package.Dependency
typealias TargetDependency = PackageDescription.Target.Dependency
typealias Target = PackageDescription.Target
typealias Product = PackageDescription.Product

// MARK: - Library

let packageDependencies: [PackageDependency] = [
    .package(url: "https://github.com/firebase/firebase-ios-sdk", from: .init(10, 11, 0)),
    .package(url: "https://github.com/yazio/ReadabilityModifier", from: .init(1, 0, 0)),
    .package(url: "https://github.com/exyte/PopupView", from: .init(2, 5, 7)),
]

let readabilityModifier: TargetDependency = .product(name: "ReadabilityModifier", package: "ReadabilityModifier")
let analytics: TargetDependency = .product(name: "FirebaseAnalytics", package: "firebase-ios-sdk")
let fireAuth: TargetDependency = .product(name: "FirebaseAuth", package: "firebase-ios-sdk")
let fireStore: TargetDependency = .product(name: "FirebaseFirestore", package: "firebase-ios-sdk")
let popupView: TargetDependency = .product(name: "PopupView", package: "PopupView")

// MARK: - Targets

extension Target {
    static func core(name: String, dependencies: [TargetDependency], resources: [Resource]? = nil, plugins: [Target.PluginUsage]? = nil) -> Target {
        .target(name: name, dependencies: dependencies, path: "Sources/Core/\(name)", resources: resources, plugins: plugins)
    }

    static func feature(name: String, dependencies: [TargetDependency], resources: [Resource]? = nil, plugins: [Target.PluginUsage]? = nil) -> Target {
        .target(name: name, dependencies: dependencies, path: "Sources/Feature/\(name)", resources: resources, plugins: plugins)
    }
}

// MARK: Feature

let coreTargets: [Target] = [
    .core(name: "ViewComponents", dependencies: [])
]

let featureTargets: [Target] = [
    .feature(name: "SignUp", dependencies: [
        fireAuth,
        fireStore,
        readabilityModifier,
        popupView
    ])
]

// MARK: - Package

let allTargets = coreTargets + featureTargets

let package = Package(
    name: "SwapWithMe",
    platforms: [.iOS(.v15)],
    products: allTargets
        .map{ $0.name }
        .map{ .library(name: $0, targets: [$0]) },
    dependencies: packageDependencies,
    targets: [
        .target(
            name: "ViewComponents",
            dependencies: [],
            path: "Sources/Core/ViewComponents"
        ),
        .target(
            name: "SignUp",
            dependencies: [
                fireAuth,
                fireStore,
                readabilityModifier,
                popupView
            ],
            path: "Sources/Feature/SignUp"
        )
    ]
)
