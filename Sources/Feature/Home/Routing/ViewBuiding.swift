////
////  ViewBuilder.swift
////
////
////  Created by 濵田　悠樹 on 2023/12/01.
////
//
import SwiftUI
//
///// プロジェクトApp で画面遷移をDIするための仲介役
//public struct ViewBuilding {
//    let builder: (_ veiwType: ViewType) -> AnyView
//
//    public func build(viewType: ViewType) -> some View {
//        builder(viewType)
//    }
//}
//
///// extension ViewBuilder 用
public protocol ViewBuidingrProtocol {
    // プロジェクトApp の build() にて推論
    associatedtype ResultView: View

    func build(viewType: ViewType) -> ResultView
}

///// モジュールから呼び出される
///// 表示するViewをジェネリクスを用いて指定する
//extension ViewBuilding {
//    public init<T: ViewBuidingrProtocol>(viewBuilding: T) {
//        // 画面遷移するときに呼び出される
//        let build = viewBuilding.build(viewType:)
//        builder = { viewType in
//            AnyView(build(viewType))
//        }
//    }
//}

