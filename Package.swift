// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwapWithMe",
    // 対象とする Minバージョンを指定
    platforms: [.iOS(.v13)],
    // モジュール の依存関係を定義
    products: [
        .library(name: "Feature", targets: ["Feature"])
    ],
    // ライブラリ の依存関係を定義
    dependencies: [
    ],
    // target や test 用の target を追加していく
    targets: [
        .target(name: "Feature")
    ]
)
