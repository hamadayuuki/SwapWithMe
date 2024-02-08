//
//  PartnerCardsView.swift
//
//
//  Created by 濵田　悠樹 on 2023/08/03.
//

/*
TODO: カードに載せる情報を増やす
    - Swapした日付
    - どこで出会ったか
    (- 相手の特徴的なものも？)
 */

import ComposableArchitecture
import Dependencies
import PartnerCardsStore
import ReadabilityModifier
import Routing
import SwiftUI
import User
import ViewComponents

public struct PartnerCardsView: View {
    @Dependency(\.viewBuildingClient.questionListView) var questionListView

    let store: StoreOf<PartnerCardsStore>

    public init(store: StoreOf<PartnerCardsStore>) {
        self.store = store
    }

    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            NavigationView {
                ScrollView {
                    VStack(alignment: .leading, spacing: 18) {
                        Text("Swapしたユーザー")
                            .font(.system(size: 24, weight: .bold, design: .rounded))

                        Text("これまでカードを交換したユーザーが表示されています。カードをタップすると質問が表示されます。")
                            .font(.system(size: 12, weight: .regular, design: .rounded))
                            .padding(.bottom, 24)

                        // カードが11枚を想定して、値は決め打ち
                        ForEach(0..<5) { i in
                            HStack(spacing: 12) {
                                ForEach(0..<3) { j in
                                    if let cardImage = viewStore.cardImages[safe: i * 3 + j],
                                        let partnerInfo = viewStore.partnerInfos[safe: i * 3 + j]
                                    {
                                        CardView(cardImage: cardImage, partner: partnerInfo)
                                            .onTapGesture {
                                                viewStore.send(.tappedPartnerCard(cardImage))
                                            }
                                    }
                                }
                            }
                        }

                        NavigationLink(
                            destination: questionListView(viewStore.tappedImage),
                            isActive: viewStore.$isTransQuestionListView
                        ) {
                            EmptyView()
                        }
                    }
                    .fitToReadableContentGuide()
                    .padding(.top, 36)
                }
            }
            .onAppear {
                viewStore.send(.onAppear)
            }
        }
    }
}

struct PartnerCardsView_Previews: PreviewProvider {
    static var previews: some View {
        PartnerCardsView(
            store: Store(initialState: PartnerCardsStore.State()) {
                PartnerCardsStore()
            }
        )
    }
}
