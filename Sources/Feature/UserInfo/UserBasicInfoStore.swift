//
//  UserBasicInfoStore.swift
//
//
//  Created by 濵田　悠樹 on 2023/08/09.
//

import ComposableArchitecture
import Foundation
import User

public struct UserBasicInfoStore: ReducerProtocol {
    public init() {}

    public struct State: Equatable {
        public init() {}

        var user: User? = nil
        var tappedTransButton = false
    }

    public enum Action: Equatable {
        case tappedButton(User?)
        case bindingTappedTransButton(Bool)
    }

    public func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
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
