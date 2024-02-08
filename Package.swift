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
    .package(url: "https://github.com/pointfreeco/swift-composable-architecture", from: .init(1, 2, 0)),
    .package(url: "https://github.com/pointfreeco/swift-dependencies", from: .init(1, 1, 0)),
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
let dependencies: TargetDependency = .product(name: "Dependencies", package: "swift-dependencies")
let dependenciesMacros: TargetDependency = .product(name: "DependenciesMacros", package: "swift-dependencies")
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

    static func featureStore(name: String, dependencies: [TargetDependency], resources: [Resource]? = nil, plugins: [Target.PluginUsage]? = nil) -> Target {
        .target(name: name, dependencies: dependencies, path: "Sources/FeatureStore/\(name)", resources: resources, plugins: plugins)
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

    // TODO: - test に統合
    static func dataTest(name: String, dependencies: [TargetDependency], resources: [Resource]? = nil, plugins: [Target.PluginUsage]? = nil) -> Target {
        .testTarget(name: name, dependencies: dependencies, path: "Tests/Data/\(name)", resources: resources, plugins: plugins)
    }
}

// MARK: Feature

let coreTargets: [Target] = [
    .core(name: "ViewComponents", dependencies: [
        nuke,
        cropViewController
    ]),
    .core(name: "Error", dependencies: []),
    .core(name: "Routing", dependencies: [
        "User",
        "PartnerCardsStore",
        "SearchStore",
        composableArchitecture,
        dependencies,
        dependenciesMacros,
    ])
]

let featureTargets: [Target] = [
    .feature(name: "SignUp", dependencies: [
        "SignUpStore",
        "ViewComponents",
        fireAuth,
        fireStore,
        readabilityModifier,
        popupView,
        composableArchitecture
    ]),
    .feature(name: "UserInfo", dependencies: [
        "UserInfoStore",
        "ViewComponents",
        "User",
        "Request",
        "Routing",
        readabilityModifier,
        popupView,
        composableArchitecture,
        dependencies,
    ]),
    .feature(name: "Home", dependencies: [
        "ViewComponents",
        "User",
        "Routing",
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
        "PartnerCardsStore",
        "ViewComponents",
        "User",
        "Routing",
        readabilityModifier,
        popupView,
        composableArchitecture,
        dependencies
    ]),
    .feature(name: "Tab", dependencies: [
        "PartnerCardsStore",
        "SearchStore",
        "Routing",
        readabilityModifier,
        popupView,
        dependencies,
    ]),
    .feature(name: "Search", dependencies: [
        "SearchStore",
        "User",
        "ViewComponents",
        "Routing",
        readabilityModifier,
        composableArchitecture,
        dependencies,
    ]),
    .feature(name: "MyProfile", dependencies: [
        "User",
        "ViewComponents",
        readabilityModifier,
    ]),
]

let featureStoreTargets: [Target] = [
    .featureStore(name: "PartnerCardsStore", dependencies: [
        "User",
        composableArchitecture,
    ]),
    .featureStore(name: "SearchStore", dependencies: [
        "Request",
        "User",
        composableArchitecture,
    ]),
    .featureStore(name: "SignUpStore", dependencies: [
        fireAuth,
        composableArchitecture,
    ]),
    .featureStore(name: "UserInfoStore", dependencies: [
        "Request",
        "User",
        composableArchitecture,
    ]),
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
        "Error",
        fireStore,
        fireStoreSwift,
        fireStorage,
        dependencies
    ]),
    .data(name: "API", dependencies: [
        "Error"
    ]),
]

let featureTestTargets: [Target] = [
    .featureTest(
        name: "UserInfoTest",
        dependencies: [
            "UserInfoStore",
            "User",
            composableArchitecture
        ]),
    .featureTest(
        name: "SearchTest",
        dependencies: [
            "SearchStore",
            "User",
            composableArchitecture
        ])
]

let dataTestTargets: [Target] = [
    .dataTest(
        name: "APITest",
        dependencies: [
            "Error"
        ])
]

// MARK: - Package

let allTargets = coreTargets + featureTargets + featureStoreTargets + entityTargets + dataTargets + featureTestTargets + dataTestTargets

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
