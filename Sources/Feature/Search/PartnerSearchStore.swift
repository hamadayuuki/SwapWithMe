//
//  PartnerSearchStore.swift
//
//
//  Created by 濵田　悠樹 on 2023/10/25.
//

import ComposableArchitecture
import Request
import User

public struct PartnerSearchStore: ReducerProtocol {
    public struct State: Equatable {
        var users: [User] = []
        var myInfo: User = .init(iconURL: nil, name: "", age: 0, sex: .man, affiliation: .juniorHigh, animal: .dog, activity: .indoor, personality: .shy, description: "")
        var partner: User = .init(iconURL: nil, name: "", age: 0, sex: .man, affiliation: .juniorHigh, animal: .dog, activity: .indoor, personality: .shy, description: "")
        var isTransHomeView = false
    }

    public enum Action: Equatable {
        case onAppear
        case setMyInfo(User)
        case tappedPartnerCell(User)
        case search(String)
        case setUsers([User])
    }

    public func reduce(into state: inout State, action: Action) -> EffectTask<Action> {
        switch action {
        case .onAppear:
            return .run { send in
                // TODO: uid はログインしているユーザー情報から取得してくる
                /// 現在の uid はテストユーザー
                let myInfo = try await UserRequest.fetch(id: "8FA167F4-E3CD-449A-92F2-7FC2CB5CB0B4")
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
                let users = try await UserRequest.fetchWithName(name: text)
                await send(.setUsers(users))
            }
        case .setUsers(let users):
            state.users = users
            return .none
        }
    }

    public init() {}
}
