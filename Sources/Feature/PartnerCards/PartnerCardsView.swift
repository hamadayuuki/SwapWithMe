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
import MyProfileStore
import PartnerCardsStore
import QuestionListStore
import ReadabilityModifier
import Routing
import SwiftUI
import User
import ViewComponents

public struct PartnerCardsView: View {
    @Dependency(\.viewBuildingClient.questionListView) var questionListView
    @Dependency(\.viewBuildingClient.myProfileView) var myProfileView

    let store: StoreOf<PartnerCardsStore>

    public init(store: StoreOf<PartnerCardsStore>) {
        self.store = store
    }

    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            ZStack {
                // カード一覧
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 6) {
                        Text("Swapしたユーザー")
                            .font(.system(size: 24, weight: .bold, design: .rounded))

                        Text("これまでカードを交換したユーザーが表示されています。カードをタップすると質問が表示されます。")
                            .font(.system(size: 12, weight: .regular, design: .rounded))
                            .padding(.bottom, 18)

                        // 横3枚 × 縦x枚
                        VStack(spacing: 12) {
                            ForEach(0..<Int(viewStore.followings.count / 3) + 1, id: \.self) { i in
                                HStack(spacing: 12) {
                                    ForEach(0..<3) { j in
                                        if let user = viewStore.followings[safe: i * 3 + j] {
                                            CardView(user: user)
                                                .onTapGesture {
                                                    viewStore.send(.tappedPartnerCard(user))
                                                }
                                        } else {
                                            Color(.clear)
                                                .frame(width: 250 * 0.42, height: 400 * 0.42)
                                        }
                                    }
                                }
                                .frame(maxWidth: .infinity, alignment: .center)
                            }
                        }
                    }
                    .padding(.top, 80)
                }

                // 画面上部
                HStack {
                    Image(systemName: "person.fill.badge.plus")
                        .font(.system(size: 24, weight: .bold, design: .rounded))
                        .frame(maxWidth: .infinity, alignment: .leading)

                    Text("SwapWithMe")
                        .font(.system(size: 24, weight: .bold, design: .rounded))
                        .frame(width: 240)

                    Button(action: {
                        viewStore.send(.tappedMyProfileImage)
                    }) {
                        Image("hotta")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 30, height: 30)
                            .cornerRadius(15)
                            .overlay(
                                RoundedRectangle(cornerRadius: 15).stroke(Color.black, lineWidth: 1)
                            )
                            .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                }
                .frame(maxHeight: .infinity, alignment: .top)

                // 画面遷移
                NavigationLink(
                    destination: questionListView(
                        viewStore.tappedPartner,
                        Store(initialState: QuestionListStore.State()) {
                            QuestionListStore()
                        }
                    ),
                    isActive: viewStore.$isTransQuestionListView
                ) {
                    EmptyView()
                }

                NavigationLink(
                    destination: myProfileView(
                        Store(initialState: MyProfileStore.State()) {
                            MyProfileStore()
                        }
                    ),
                    isActive: viewStore.$isTransMyProfileView
                ) {
                    EmptyView()
                }
            }
            .fitToReadableContentGuide()
            .onAppear {
                viewStore.send(.onAppear("18D93893-3CAC-41B3-82AA-3B8A3EFDEBD6"))
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
