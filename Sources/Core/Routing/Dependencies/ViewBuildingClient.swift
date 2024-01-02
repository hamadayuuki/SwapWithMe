//
//  ViewBuildingClient.swift
//
//
//  Created by 濵田　悠樹 on 2023/12/24.
//

import ComposableArchitecture
import Dependencies
import PartnerCardsStore
import SwiftUI
import User

public struct ViewBuildingClient {
    public var firstView: @Sendable (_ id: Int) -> AnyView
    public var secondView: @Sendable () -> AnyView
    public var questionListView: @Sendable (_ cardImage: Image) -> AnyView
    public var homeView: @Sendable (_ myInfo: User, _ partner: User) -> AnyView
    public var partnerCardsView: @Sendable (_ store: StoreOf<PartnerCardsStore>) -> AnyView

    public init(
        firstView: @escaping @Sendable (Int) -> AnyView,
        secondView: @escaping @Sendable () -> AnyView,
        questionListView: @escaping @Sendable (Image) -> AnyView,
        homeView: @escaping @Sendable (User, User) -> AnyView,
        partnerCardsView: @escaping @Sendable (StoreOf<PartnerCardsStore>) -> AnyView
    ) {
        self.firstView = firstView
        self.secondView = secondView
        self.questionListView = questionListView
        self.homeView = homeView
        self.partnerCardsView = partnerCardsView
    }
}

// MARK: - Dependnecies

extension ViewBuildingClient: TestDependencyKey {
    public static let testValue: ViewBuildingClient = .init(
        firstView: unimplemented(),
        secondView: unimplemented(),
        questionListView: unimplemented(),
        homeView: unimplemented(),
        partnerCardsView: unimplemented()
    )
}

extension DependencyValues {
    public var viewBuildingClient: ViewBuildingClient {
        get { self[ViewBuildingClient.self] }
        set { self[ViewBuildingClient.self] = newValue }
    }
}
