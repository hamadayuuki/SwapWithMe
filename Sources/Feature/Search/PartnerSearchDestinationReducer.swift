//
//  PartnerSearchDestinationReducer.swift
//
//
//  Created by 濵田　悠樹 on 2023/10/28.
//

import ComposableArchitecture
import User

extension PartnerSearchStore {
    /// 画面遷移用
    public struct Destination: Reducer {
        /// 行き先を指定する際は State をenum型で定義する
        public enum State: Equatable {
            case homeView(PartnerSearchStore.State)
        }

        public enum Action: Equatable {
            case homeView(PartnerSearchStore.Action)
        }

        /// Destination に PartnerSearchStore を組み込む
        public var body: some ReducerOf<Self> {
            Scope(state: /State.homeView, action: /Action.homeView) {
                PartnerSearchStore()
            }
        }
    }
}
