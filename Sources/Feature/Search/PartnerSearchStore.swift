//
//  PartnerSearchStore.swift
//  
//
//  Created by 濵田　悠樹 on 2023/10/25.
//

import ComposableArchitecture
import User
import Request

public struct PartnerSearchStore: ReducerProtocol {
    public struct State: Equatable {
        var myInfo: User = .init(iconURL: nil, name: "", age: 0, sex: .man, affiliation: .juniorHigh, animal: .dog, activity: .indoor, personality: .shy, description: "")
    }

    public enum Action: Equatable {
        case onAppear
        case setMyInfo(User)
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
        case let .setMyInfo(myInfo):
            state.myInfo = myInfo
            return .none
            
        }
    }

    public init() {}
}

