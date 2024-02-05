//
//  UserBasicInfoStore.swift
//
//
//  Created by 濵田　悠樹 on 2023/08/09.
//

import ComposableArchitecture
import Foundation
import User

public struct UserBasicInfoStore: Reducer {
    public init() {}

    public struct State: Equatable {
        public init() {}

        public var user: User? = nil
        public var tappedTransButton = false
    }

    public enum Action: Equatable {
        case tappedButton(User?)
        case bindingTappedTransButton(Bool)
    }

    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .tappedButton(let user):
                state.user = user
                state.tappedTransButton = true
                return .none

            case .bindingTappedTransButton(let ver):
                state.tappedTransButton = ver
                return .none
            }
        }
    }
}
