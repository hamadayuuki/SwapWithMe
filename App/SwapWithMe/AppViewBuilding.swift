//
//  ViewBuilding.swift
//  SwapWithMe
//
//  Created by 濵田　悠樹 on 2023/12/01.
//

import Home  // Home>Routing を使用するため
import SwiftUI

/// 画面遷移の実装
/// モジュールへDIする
struct AppViewBuilding: ViewBuildingProtocol {
    func build(viewType: ViewType) -> some View {
        switch viewType {
        case .firstView(let id):
            return Text("First View")
        case .secondView:
            return Text("Second View")
        }
    }
}
