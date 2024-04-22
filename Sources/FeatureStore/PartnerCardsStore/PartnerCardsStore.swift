//
//  PartnerCardsStore.swift
//
//
//  Created by 濵田　悠樹 on 2023/11/07.
//

import ComposableArchitecture
import SwiftUI
import User

public struct PartnerCardsStore: Reducer {
    public struct State: Equatable {
        public init() {}

        public var follows: [User] = []
        public var tappedPartner: User? = nil
        @BindingState public var isTransQuestionListView = false
        @BindingState public var isTransMyProfileView = false
    }

    public enum Action: Equatable, BindableAction {
        case onAppear
        case tappedPartnerCard(User)
        case binding(BindingAction<State>)
        case tappedMyProfileImage
    }

    public var body: some ReducerOf<Self> {
        BindingReducer()

        Reduce { state, action in
            switch action {
            case .onAppear:
                state.follows = [User.stub(), User.stub(), User.stub(), User.stub()]
                return .none

            case .tappedPartnerCard(let partner):
                state.tappedPartner = partner
                state.isTransQuestionListView = true
                return .none

            case .tappedMyProfileImage:
                state.isTransMyProfileView = true
                return .none

            case .binding:
                return .none
            }
        }
    }

    public init() {}
}
