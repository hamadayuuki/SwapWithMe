//
//  Environment+extension.swift
//
//
//  Created by 濵田　悠樹 on 2023/12/01.
//

import SwiftUI

// カスタムEnvironmentObject を作成

// MARK: - ViewBuilder

//extension EnvironmentValues {
//    private struct Key: EnvironmentKey {
//        static var defaultValue: ViewBuilding {
//            ViewBuilding { _ in
//                // ビルド時は EmptyView() を指定
//                // 本来は画面遷移先の画面を指定する必要がある
//                // しかし、画面を指定するとビルド時間が長くなってしまうので、実行時に指定する
//                AnyView(EmptyView())
//            }
//        }
//    }
//
//    public var viewBuilding: ViewBuilding {
//        get { self[Key.self] }
//        set { self[Key.self] = newValue }
//    }
//}
