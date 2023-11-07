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
import QuestionList
import ReadabilityModifier
import SwiftUI
import User

public struct PartnerCardsView: View {
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
                        ForEach(0..<3) { i in
                            HStack(spacing: 12) {
                                // 最終行の時
                                if i == (3 - 1) {
                                    ForEach(0..<11 % 3) { j in
                                        partnerCard(cardImage: viewStore.cardImages[i * 3 + j], partner: viewStore.partnerInfos[i * 3 + j])
                                            .onTapGesture {
                                                viewStore.send(.tappedPartnerCard(viewStore.cardImages[i * 3 + j]))
                                            }
                                    }
                                } else {
                                    ForEach(0..<3) { j in
                                        partnerCard(cardImage: viewStore.cardImages[i * 3 + j], partner: viewStore.partnerInfos[i * 3 + j])
                                            .onTapGesture {
                                                viewStore.send(.tappedPartnerCard(viewStore.cardImages[i * 3 + j]))
                                            }
                                            .onAppear {
                                                print(i * 3 + j)
                                            }
                                    }
                                }
                            }
                        }

                        NavigationLink(
                            destination: QuestionListView(cardImage: viewStore.tappedImage),
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

    private func partnerCard(cardImage: Image, partner: PartnerInfo) -> some View {
        ZStack {
            card(cardImage: cardImage)
            partnerInfo(name: partner.name, age: partner.age, affiliation: partner.personality)
                .offset(x: 0, y: 400 * 0.42 * 0.25)
        }
    }

    private func card(cardImage: Image) -> some View {
        ZStack {
            cardImage
                .resizable()
                .scaledToFill()

            LinearGradient(
                gradient: Gradient(colors: [.clear, .black.opacity(0.7)]),
                startPoint: .top,
                endPoint: .bottom
            )
        }
        .frame(width: 250 * 0.42, height: 400 * 0.42)
        .cornerRadius(20)
    }

    private func partnerInfo(name: String, age: Int, affiliation: String) -> some View {
        VStack(spacing: 6) {
            Text("\(name)")
                .font(.system(size: 12, weight: .bold, design: .rounded))

            HStack(spacing: 6) {
                Text("\(age)歳")

                Text("\(affiliation)")
            }
            .font(.system(size: 8, weight: .medium, design: .rounded))
        }
        .foregroundColor(.white)
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
