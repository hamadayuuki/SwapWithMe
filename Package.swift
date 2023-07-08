// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

typealias PackageDependency = PackageDescription.Package.Dependency
typealias TargetDependency = PackageDescription.Target.Dependency
typealias Target = PackageDescription.Target
typealias Product = PackageDescription.Product

// MARK: - Library

let packageDependencies: [PackageDependency] = [
    .package(url: "https://github.com/yazio/ReadabilityModifier", from: .init(1, 0, 0)),
]

let readabilityModifier: TargetDependency = .product(name: "ReadabilityModifier", package: "ReadabilityModifier")

// MARK: - Targets

extension Target {
    static func feature(name: String, dependencies: [TargetDependency], resources: [Resource]? = nil, plugins: [Target.PluginUsage]? = nil) -> Target {
        .target(name: name, dependencies: dependencies, path: "Sources/Feature/\(name)", resources: resources, plugins: plugins)
    }
}

// MARK: Feature

let featureTargets: [Target] = [
    .feature(name: "SignUp", dependencies: [readabilityModifier])
]

// MARK: - Package

let allTargets = featureTargets

let package = Package(
    name: "SwapWithMe",
    platforms: [.iOS(.v14)],
    products: allTargets
        .map{ $0.name }
        .map{ .library(name: $0, targets: [$0]) },
    dependencies: packageDependencies,
    targets: [
        .target(
            name: "SignUp",
            dependencies: [
                readabilityModifier
            ],
            path: "Sources/Feature/SignUp"
        )
    ]
)
