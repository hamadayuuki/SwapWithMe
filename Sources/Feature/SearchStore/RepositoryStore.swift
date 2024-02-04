//
//  File.swift
//
//
//  Created by 濵田　悠樹 on 2024/01/02.
//

import ComposableArchitecture
import Foundation

public struct RepositoryStore: Reducer {
    public init() {}

    // MARK: - State

    public struct State: Equatable {
        public init() {}

        public var ripositories: [String] = [""]
    }

    // MARK: - Action

    public enum Action: Equatable {
        case onAppear
    }

    // MARK: - Reducer

    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            // 1 : Action に応じて
            switch action {
            case .onAppear:
                // 2 : State を変更する
                state.ripositories = ["repository1"]
                return .none
            }
        }
    }
}
