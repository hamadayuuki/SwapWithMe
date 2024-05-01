//
//  QuestionListStore.swift
//
//
//  Created by 濵田　悠樹 on 2024/05/01.
//

import ComposableArchitecture
import Dependencies
import Request
import User

public struct QuestionListStore: Reducer {
    public init() {}

    public struct State: Equatable {
        public init() {}

        public var partner: User = .stub()
    }

    public enum Action: Equatable {
        case onAppear(User)
    }

    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear(let partner):
                state.partner = partner
                return .none
            }
        }
    }
}
