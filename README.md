# SwapWithMe

## SPMマルチモジュール構成

プロジェクトの構成として SPMを中心としたマルチモジュール を採用しています。[pointfreeco/isowords](https://github.com/pointfreeco/isowords)を参考にしています。
プロジェクト構成は以下の通りです。

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