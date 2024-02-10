//
//  ViewBuildingClient.swift
//
//
//  Created by 濵田　悠樹 on 2023/12/24.
//

import ComposableArchitecture
import Dependencies
import DependenciesMacros
import MyProfileStore
import PartnerCardsStore
import SearchStore
import SwiftUI
import User

@DependencyClient
public struct ViewBuildingClient {
    // Test でunimplemented()を使用するためデフォルト値が必要なため "= {}"を追加している
    public var questionListView: @Sendable (_ cardImage: Image) -> AnyView = { _ in AnyView(EmptyView()) }
    public var homeView: @Sendable (_ myInfo: User, _ partner: User) -> AnyView = { _, _ in AnyView(EmptyView()) }
    public var partnerCardsView: @Sendable (_ store: StoreOf<PartnerCardsStore>) -> AnyView = { _ in AnyView(EmptyView()) }
    public var partnerSearchView: @Sendable (_ store: StoreOf<PartnerSearchStore>) -> AnyView = { _ in AnyView(EmptyView()) }
    public var appTabView: @Sendable () -> AnyView = { AnyView(EmptyView()) }
    public var myProfileView: @Sendable (_ store: StoreOf<MyProfileStore>) -> AnyView = { _ in AnyView(EmptyView()) }
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
