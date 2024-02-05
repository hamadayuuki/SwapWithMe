//
//  SelectUserCardImageStore.swift
//
//
//  Created by 濵田　悠樹 on 2023/08/09.
//

import ComposableArchitecture
import Request
import SwiftUI
import User

public struct SelectUserCardImageStore: Reducer {
    public init() {}

    public struct State: Equatable {
        public init() {}

        public var user: User? = nil
        public var isTransAppTabView = false
    }

    public enum Action: Equatable {
        case onAppear(User?)
        case tappedButton(UIImage?)
        case successSetImage(URL)
        case successSetUser
        case bindingIsTransAppTabView(Bool)
    }

    public var body: some ReducerOf<Self> {
        @Dependency(\.userRequestClient) var userRequestClient

        Reduce { state, action in
            switch action {
            case .onAppear(let user):
                state.user = user
                return .none

            case .tappedButton(let inputImage):
                guard let id = state.user?.id else { fatalError("Error SelectUserCardImageStore.tappedButton") }
                return .run { send in
                    Task {
                        let iconURL = try await ImageRequest.set(uiImage: inputImage!, id: id)
                        await send(.successSetImage(iconURL))
                    }
                }

            case .successSetImage(let iconURL):
                state.user?.iconURL = iconURL
                guard let user = state.user else { fatalError("Error .successSetImage") }
                return .run { send in
                    try userRequestClient.set(user)
                    await send(.successSetUser)
                }

            case .successSetUser:
                state.isTransAppTabView = true
                return .none

            case .bindingIsTransAppTabView(let ver):
                state.isTransAppTabView = ver
                return .none
            }
        }
    }
}
