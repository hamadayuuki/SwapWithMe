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
    .package(url: "https://github.com/pointfreeco/swift-composable-architecture", from: .init(0, 55, 1)),
    .package(url: "https://github.com/pointfreeco/swift-dependencies", from: .init(0, 5, 1)),
    .package(url: "https://github.com/TimOliver/TOCropViewController.git", from: .init(2, 6, 1)),
    .package(url: "https://github.com/kean/Nuke.git", from: .init(12, 1, 5))
]

let readabilityModifier: TargetDependency = .product(name: "ReadabilityModifier", package: "ReadabilityModifier")
let analytics: TargetDependency = .product(name: "FirebaseAnalytics", package: "firebase-ios-sdk")
let fireAuth: TargetDependency = .product(name: "FirebaseAuth", package: "firebase-ios-sdk")
let fireStore: TargetDependency = .product(name: "FirebaseFirestore", package: "firebase-ios-sdk")
let fireStoreSwift: TargetDependency = .product(name: "FirebaseFirestoreSwift", package: "firebase-ios-sdk")
let fireStorage: TargetDependency = .product(name: "FirebaseStorage", package: "firebase-ios-sdk")
let popupView: TargetDependency = .product(name: "PopupView", package: "PopupView")
let composableArchitecture: TargetDependency = .product(name: "ComposableArchitecture", package: "swift-composable-architecture")
let dependencies: TargetDependency = .product(name: "Dependencies", package: "Dependencies")
let cropViewController: TargetDependency = .product(name: "CropViewController", package: "TOCropViewController")
let nuke: TargetDependency = .product(name: "Nuke", package: "Nuke")

// MARK: - Targets

extension Target {
    static func core(name: String, dependencies: [TargetDependency], resources: [Resource]? = nil, plugins: [Target.PluginUsage]? = nil) -> Target {
        .target(name: name, dependencies: dependencies, path: "Sources/Core/\(name)", resources: resources, plugins: plugins)
    }

    static func feature(name: String, dependencies: [TargetDependency], resources: [Resource]? = nil, plugins: [Target.PluginUsage]? = nil) -> Target {
        .target(name: name, dependencies: dependencies, path: "Sources/Feature/\(name)", resources: resources, plugins: plugins)
    }

    static func entity(name: String, dependencies: [TargetDependency], resources: [Resource]? = nil, plugins: [Target.PluginUsage]? = nil) -> Target {
        .target(name: name, dependencies: dependencies, path: "Sources/Entity/\(name)", resources: resources, plugins: plugins)
    }

    static func data(name: String, dependencies: [TargetDependency], resources: [Resource]? = nil, plugins: [Target.PluginUsage]? = nil) -> Target {
        .target(name: name, dependencies: dependencies, path: "Sources/Data/\(name)", resources: resources, plugins: plugins)
    }

    static func featureTest(name: String, dependencies: [TargetDependency], resources: [Resource]? = nil, plugins: [Target.PluginUsage]? = nil) -> Target {
        .testTarget(name: name, dependencies: dependencies, path: "Tests/Feature/\(name)", resources: resources, plugins: plugins)
    }
}

// MARK: Feature

let coreTargets: [Target] = [
    .core(name: "ViewComponents", dependencies: [
        cropViewController
    ])
]

let featureTargets: [Target] = [
    .feature(name: "SignUp", dependencies: [
        "ViewComponents",
        "UserInfo",
        fireAuth,
        fireStore,
        readabilityModifier,
        popupView,
        composableArchitecture
    ]),
    .feature(name: "UserInfo", dependencies: [
        "ViewComponents",
        "User",
        "Tab",
        "Request",
        readabilityModifier,
        popupView,
        composableArchitecture
    ]),
    .feature(name: "Home", dependencies: [
        "ViewComponents",
        "QuestionList",
        "User",
        readabilityModifier,
        popupView,
        nuke,
    ]),
    .feature(name: "QuestionList", dependencies: [
        "ViewComponents",
        readabilityModifier,
        popupView,
    ]),
    .feature(name: "PartnerCards", dependencies: [
        "ViewComponents",
        "QuestionList",
        readabilityModifier,
        popupView,
    ]),
    .feature(name: "Tab", dependencies: [
        "PartnerCards",
        "Search",
        readabilityModifier,
        popupView,
    ]),
    .feature(name: "Search", dependencies: [
        "Home",
        "Request",
        "User",
        "ViewComponents",
        readabilityModifier,
    ])
]

let entityTargets: [Target] = [
    .entity(name: "User", dependencies: [
        fireStore,
        fireStoreSwift
    ])
]

let dataTargets: [Target] = [
    .data(name: "Request", dependencies: [
        "User",
        fireStore,
        fireStoreSwift,
        fireStorage
    ])
]

let featureTestTargets: [Target] = [
    .featureTest(
        name: "UserInfoTest",
        dependencies: [
            "UserInfo",
            composableArchitecture
        ])
]

// MARK: - Package

let allTargets = coreTargets + featureTargets + entityTargets + dataTargets + featureTestTargets

let package = Package(
    name: "SwapWithMe",
    platforms: [.iOS(.v15)],
    products: allTargets
        .filter { $0.isTest == false }   // リリースするパッケージにテストを含めない
        .map{ $0.name }
        .map{ .library(name: $0, targets: [$0]) },
    dependencies: packageDependencies,
    targets: allTargets
)
