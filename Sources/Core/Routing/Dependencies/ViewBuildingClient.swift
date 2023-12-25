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

    public init(
        firstView: @escaping @Sendable (Int) -> AnyView,
        secondView: @escaping @Sendable () -> AnyView
    ) {
        self.firstView = firstView
        self.secondView = secondView
    }
}

// MARK: - Dependnecies

extension ViewBuildingClient: TestDependencyKey {
    public static let testValue: ViewBuildingClient = .init(
        firstView: unimplemented(),
        secondView: unimplemented()
    )
}

extension DependencyValues {
    public var viewBuildingClient: ViewBuildingClient {
        get { self[ViewBuildingClient.self] }
        set { self[ViewBuildingClient.self] = newValue }
    }
}
