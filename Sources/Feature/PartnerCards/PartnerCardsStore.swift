//
//  PartnerCardsStore.swift
//
//
//  Created by 濵田　悠樹 on 2023/11/07.
//

import ComposableArchitecture
import SwiftUI

public struct PartnerCardsStore: Reducer {
    public struct State: Equatable {
        public init() {}

        var cardImages: [Image] = []
    }

    public enum Action: Equatable {
        case onAppear
    }

    public var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .onAppear:
                var saveCardImages: [Image] = []
                for i in 1..<16 {
                    saveCardImages.append(Image("mock-\(i)"))
                }
                state.cardImages = saveCardImages
                return .none
            }
        }
    }

    public init() {}
}
