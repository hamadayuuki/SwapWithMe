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

        var cardImages: [Image] = []
        var partnerInfos: [PartnerInfo] = []
        var tappedImage: Image = Image("")
        @BindingState var isTransQuestionListView = false
    }

    public enum Action: Equatable, BindableAction {
        case onAppear
        case tappedPartnerCard(Image)
        case binding(BindingAction<State>)
    }

    public var body: some ReducerOf<Self> {
        BindingReducer()

        Reduce { state, action in
            switch action {
            case .onAppear:
                var saveCardImages: [Image] = []
                for i in 1..<16 {
                    saveCardImages.append(Image("mock-\(i)"))
                }
                state.cardImages = saveCardImages

                state.partnerInfos = [
                    .init(name: "かえぽん", age: 30, personality: "フレンドリー"),
                    .init(name: "るいるい", age: 22, personality: "人見知り"),
                    .init(name: "れんたん", age: 25, personality: "人見知り"),
                    .init(name: "ユウスケ", age: 19, personality: "フレンドリー"),
                    .init(name: "さくたん", age: 20, personality: "人見知り"),
                    .init(name: "しげしげ", age: 29, personality: "フレンドリー"),
                    .init(name: "ビルケイツ", age: 23, personality: "フレンドリー"),
                    .init(name: "かっきー", age: 30, personality: "人見知り"),
                    .init(name: "アイフォン", age: 22, personality: "フレンドリー"),
                    .init(name: "トランペット", age: 22, personality: "人見知り"),
                    .init(name: "いくた", age: 30, personality: "フレンドリー"),
                    .init(name: "コスメ", age: 28, personality: "人見知り"),
                    .init(name: "りこ", age: 25, personality: "人見知り"),
                    .init(name: "あかり", age: 34, personality: "フレンドリー"),
                    .init(name: "ラーメン", age: 39, personality: "人見知り"),
                ]

                return .none

            case .tappedPartnerCard(let partnerImage):
                state.tappedImage = partnerImage
                state.isTransQuestionListView = true
                return .none

            case .binding:
                return .none
            }
        }
    }

    public init() {}
}
