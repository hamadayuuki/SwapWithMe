//
//  ViewBuildingClient.swift
//
//
//  Created by 濵田　悠樹 on 2023/12/24.
//

import Dependencies
import SwiftUI

public struct ViewBuildingClient {
    public var questionListView: @Sendable (_ cardImage: Image) -> AnyView

    public init(
        questionListView: @escaping @Sendable (Image) -> AnyView
    ) {
        self.questionListView = questionListView
    }
}

// MARK: - Dependnecies

extension ViewBuildingClient: TestDependencyKey {
    public static let testValue: ViewBuildingClient = .init(
        questionListView: unimplemented()
    )
}

extension DependencyValues {
    public var viewBuildingClient: ViewBuildingClient {
        get { self[ViewBuildingClient.self] }
        set { self[ViewBuildingClient.self] = newValue }
    }
}
