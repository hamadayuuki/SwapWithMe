//
//  ViewBuilding.swift
//  SwapWithMe
//
//  Created by 濵田　悠樹 on 2023/12/01.
//

import Home  // Home>Routing を使用するため
import SwiftUI

// TODO: - ViewBuilding等の名称変更, 名称変更を行う際に 各structの目的をまとめ、コメントをつける

/// 遷移先の画面を定義
struct AppViewBuilding {
    func build(viewType: ViewType) -> some View {
        switch viewType {
        case .firstView(let id):
            return Text("FirstView")
        case .secondView:
            return Text("SecondView")
        }
    }
}

// MARK: - DI

struct AppViewBuildingKey: EnvironmentKey {
    public static var defaultValue = AppViewBuilding()
}

extension EnvironmentValues {
    var appViewBuilding: AppViewBuilding {
        get { self[AppViewBuildingKey.self] }
        set { self[AppViewBuildingKey.self] = newValue }
    }
}
