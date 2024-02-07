//
//  ViewBuildingClient.swift
//
//
//  Created by 濵田　悠樹 on 2023/12/24.
//

import Dependencies
import DependenciesMacros
import SwiftUI
import User

@DependencyClient
public struct ViewBuildingClient {
    // Test でunimplemented()を使用するためデフォルト値が必要なため "= {}"を追加している
    public var questionListView: @Sendable (_ cardImage: Image) -> AnyView = { _ in AnyView(EmptyView()) }
    public var homeView: @Sendable (_ myInfo: User, _ partner: User) -> AnyView = { _, _ in AnyView(EmptyView()) }
}

// MARK: - Dependnecies

extension ViewBuildingClient: TestDependencyKey {
    public static let testValue = Self()
}

extension DependencyValues {
    public var viewBuildingClient: ViewBuildingClient {
        get { self[ViewBuildingClient.self] }
        set { self[ViewBuildingClient.self] = newValue }
    }
}
