//
//  PartnerSearchStore.swift
//
//
//  Created by 濵田　悠樹 on 2023/10/25.
//

import ComposableArchitecture
import Request
import User

public struct PartnerSearchStore: Reducer {
    public struct State: Equatable {
        var users: [User] = []
        var myInfo: User = .init(iconURL: nil, name: "", age: 0, sex: .man, affiliation: .juniorHigh, animal: .dog, activity: .indoor, personality: .shy, description: "")
        var partner: User = .init(iconURL: nil, name: "", age: 0, sex: .man, affiliation: .juniorHigh, animal: .dog, activity: .indoor, personality: .shy, description: "")
        var isTransHomeView = false
        @BindingState var searchText = ""
        @PresentationState var destination: Destination.State?

        public init() {}
    }

    public enum Action: Equatable, BindableAction {
        case onAppear
        case setMyInfo(User)
        case tappedPartnerCell(User)
        case search(String)
        case setUsers([User])
        case bindingIsTransHomeView(Bool)
        case binding(BindingAction<State>)
        case destination(PresentationAction<Destination.Action>)
    }

    public var body: some ReducerOf<Self> {
        @Dependency(\.userRequestClient) var userRequestClient

        BindingReducer()
        Reduce { state, action in
            switch action {
            case .onAppear:
                return .run { send in
                    // TODO: uid はログインしているユーザー情報から取得してくる
                    /// 現在の uid はテストユーザー
                    let myInfo = try await userRequestClient.fetch("8FA167F4-E3CD-449A-92F2-7FC2CB5CB0B4")
                    await send(.setMyInfo(myInfo))
                }
            case .setMyInfo(let myInfo):
                state.myInfo = myInfo
                return .none
            case .tappedPartnerCell(let partner):
                state.partner = partner
                state.isTransHomeView = true
                return .none
            case .search(let text):
                return .run { send in
                    let users = try await userRequestClient.fetchWithName(text)
                    await send(.setUsers(users))
                }
            case .setUsers(let users):
                state.users = users
                return .none
            case .bindingIsTransHomeView(let ver):
                state.isTransHomeView = ver
                return .none
            case .binding:
                return .none
            case .destination:
                return .none
            }
        }
        // Destination へ接続するために必要
        // destination が Optional な状態として保持されており、その Optional な状態と接続するために Swift の Optional binding のような名前の ifLet という API を利用する必要がある
        .ifLet(\.$destination, action: /Action.destination) {
            Destination()
        }
    }

    public init() {}
}
