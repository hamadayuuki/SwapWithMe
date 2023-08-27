# SwapWithMe

## SPMマルチモジュール構成

プロジェクトの構成として SPMを中心としたマルチモジュール を採用しています。[pointfreeco/isowords](https://github.com/pointfreeco/isowords)を参考にしています。
プロジェクト構成は以下の通りです。構成を確認したい場合は、[Package.swift](https://github.com/hamadayuuki/SwapWithMe/blob/main/Package.swift) から確認してください。

```
.
├── App
│   ├── Package.swift
│   ├── SwapWithMe
│   ├── SwapWithMe.xcodeproj
│   ├── SwapWithMeTests
│   └── SwapWithMeUITests
├── Package.swift
├── README.md
├── Sources   // SPM
│   └── Feature   // Module
└── Tests
```
※ 現在 Feature同士がお互いの存在を知っている状態で画面遷移を実装しています。今後 `MainAppにて画面遷移を実装` + `抽象化 `+ `Swift-dependenciesを用いたDI` によって画面遷移を実装予定です。

### テストについて

#### TestPlan を作成しテストを実行する

SPMマルチモジュール構成を採用するとモジュールとしてテストを書くため、`TestPlan` を作り モジュール(テスト)毎にテストするかを明示的に指定する必要があります
指定しない場合、テストコード上に `♦︎マーク` が出てこないため、テストを実行できません

 1: `Product` > `Test Plan` > `New Test Plan ...`
 2: 作成された Test Plan へ移動
 3: 画面左下の + を押し > `対象のテストモジュール` を追加
 
 #### Pakage.swift の変更
 
 テストをリリースするパッケージ(今回でいうとSwapWithMeというアプリ)にテストを含めないようにする
 
 ```diff
 Package(
    name: "SwapWithMe",
    platforms: [.iOS(.v15)],
    products: allTargets
+        .filter { $0.isTest == false }   // リリースするパッケージにテストを含めない
        .map{ $0.name }
        .map{ .library(name: $0, targets: [$0]) },
    dependencies: packageDependencies,
    targets: allTargets
)
```

## 実行環境設定

### Xcode

前提として、`Xcode@14.3` と `homebrew` はインストールされているものとします。

### Format & Lint

#### 1. homebrew で mint をインストール

CLI は mint で管理しています。
CLIには[apple/swift-format](https://github.com/apple/swift-format)が含まれます。

Appleが公開しているコード整形ライブラリ。swift-formatの整形規則は[.swift-format](https://github.com/hamadayuuki/yumemi-ios-engineer-codecheck/blob/main/.swift-format)に記述しています。

```sh
brew install mint
```

#### 2. Mintfile を記述

Mintパッケージマネージャを使用してSwiftコマンドラインツールを管理する際に使用されるファイル

```Mintfile
apple/swift-format
```

#### 3. mint で管理している CLI をインストール

Mintfile に書かれている CLI がインストールされます。インストールした CLI は `mint run <command名>` で実行可能です。

```sh
cd プロジェクト
mint bootstrap
```

#### 4. swift-fomatを使用した自動整形の実行

`Xcode > Bulid Target(iOSEngineerCodeCheck) > Bulid Phases > +`> New Run Script Phase > "Swift-format and Lint"

<img width = 80% src = "README/xcode-swift-format.png">

Bulid Phases に `Swift-format and Lint` という名称で、以下の自動実行用のスクリプトを書く。

ビルドされるたびに以下のスクリプトが実行される。
SwapWithMe : XCodeProjのswiftファイル
../Sources : SPM モジュールのswiftファイル

```sh
# `-p/--parallel` `-r/--recursive` `-i/--in-place` `-s/--strict`
# ../Sources : SPM modules
xcrun --sdk macosx mint run swift-format swift-format -p -r -i SwapWithMe ../Sources
xcrun --sdk macosx mint run swift-format swift-format lint -p -r SwapWithMe ../Sources
```
