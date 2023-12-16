//
//  File.swift
//
//
//  Created by 濵田　悠樹 on 2023/12/16.
//

import SwiftUI

// Module へ MainAppの画面遷移実装 を差し込むために定義
public protocol ViewBuildingProtocol {
    associatedtype V: View

    func build(viewType: ViewType) -> V
}
