//
//  MyProfileStore.swift
//
//
//  Created by 濵田　悠樹 on 2024/02/11.
//

import ComposableArchitecture
import SwiftUI

public struct MyProfileStore: Reducer {
    public struct State: Equatable {
        public var mySns: [SNS] = []
        public var relationStatus: [RelationStatus] = []

        public init() {}
    }

    public  enum Action: Equatable {
        case onAppear
    }

    public var body: some ReducerOf<Self> {
        Reduce { state, action  in
            switch action {
            case .onAppear:
                // TODO: 動的にする, 今は表示用にデータを決めうちで定義
                // 現在はstubしているだけ
                state.mySns = [.twitter, .instagram, .line, .other("BeReal.")]
                state.relationStatus = [.follower(100), .following(300), .yahhos(500)]
                return .none
            }
        }
    }

    public init() {}
}
