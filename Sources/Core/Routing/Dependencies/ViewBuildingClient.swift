//
//  ViewBuildingClient.swift
//
//
//  Created by 濵田　悠樹 on 2023/12/24.
//

import Dependencies
import SwiftUI

public struct ViewBuildingClient {
    public var firstView: @Sendable (_ id: Int) -> AnyView
    public var secondView: @Sendable () -> AnyView
    public var questionListView: @Sendable (_ cardImage: Image) -> AnyView

    public init(
        firstView: @escaping @Sendable (Int) -> AnyView,
        secondView: @escaping @Sendable () -> AnyView,
        questionListView: @escaping @Sendable (Image) -> AnyView
    ) {
        self.firstView = firstView
        self.secondView = secondView
        self.questionListView = questionListView
    }
}

// MARK: - Dependnecies

extension ViewBuildingClient: TestDependencyKey {
    public static let testValue: ViewBuildingClient = .init(
        firstView: unimplemented(),
        secondView: unimplemented(),
        questionListView: unimplemented()
    )
}

extension DependencyValues {
    public var viewBuildingClient: ViewBuildingClient {
        get { self[ViewBuildingClient.self] }
        set { self[ViewBuildingClient.self] = newValue }
    }
}
