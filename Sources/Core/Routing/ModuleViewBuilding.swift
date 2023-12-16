//
//  ModuleViewBuilding.swift
//
//
//  Created by 濵田　悠樹 on 2023/12/01.
//

import SwiftUI

// DIするために 空実装
// 将来 MainAppのViewBuilding を差し込む
public struct ModuleViewBuilding: ViewBuildingProtocol {
    public func build(viewType: ViewType) -> some View {
        return EmptyView()
    }
}
