//
//  Environment+extension.swift
//
//
//  Created by 濵田　悠樹 on 2023/12/01.
//

import SwiftUI

// MARK: - DI

struct ViewBuildingKey: EnvironmentKey {
    // デバッグ時 MainAppのViewBuilding を差し込む
    public static var defaultValue: any ViewBuildingProtocol = ModuleViewBuilding()
}

extension EnvironmentValues {
    public var viewBuilding: any ViewBuildingProtocol {
        get { self[ViewBuildingKey.self] }
        set { self[ViewBuildingKey.self] = newValue }
    }
}
