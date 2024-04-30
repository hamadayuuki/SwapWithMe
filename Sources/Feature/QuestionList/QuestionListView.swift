//
//  QuestionListView.swift
//
//
//  Created by 濵田　悠樹 on 2023/07/31.
//

import ComposableArchitecture
import QuestionListStore
import ReadabilityModifier
import SwiftUI
import User
import ViewComponents

public struct QuestionListView: View {
    private let cardSize: CGSize = .init(width: 250 * 1.7, height: 400 * 1.7)
    var partner: User

    let store: StoreOf<QuestionListStore>

    public init(partner: User, store: StoreOf<QuestionListStore>) {
        self.partner = partner
        self.store = store
    }

    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            ScrollView {
                VStack(spacing: 32) {
                    ZStack {
                        card(partner: self.partner)
                    }

                    // TODO: - ユーザー情報追加
                }
                .fitToReadableContentGuide()
            }
            .onAppear {
                viewStore.send(.onAppear(self.partner))
            }
        }
    }

    private func card(partner: User) -> some View {
        ZStack(alignment: .top) {
            CardView(user: partner, cardSize: cardSize, fontSize: 18)

            Text("2023/04/01")
                .font(.system(size: 12, weight: .bold, design: .rounded))
                .foregroundColor(.white)
                .frame(width: cardSize.width * 0.42 * 0.7, height: 20)
                .background(Color.green.cornerRadius(5))
        }
        .frame(width: cardSize.width * 0.42, height: cardSize.height * 0.42)
        .cornerRadius(20)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.green, lineWidth: 4)
        )
    }

    private func partnerInfo(name: String, age: Int, affiliation: String) -> some View {
        VStack(spacing: 6) {
            Text("\(name)")
                .font(.system(size: 18, weight: .bold, design: .rounded))

            HStack(spacing: 6) {
                Text("\(age)歳")

                Text("\(affiliation)")
            }
            .font(.system(size: 12, weight: .medium, design: .rounded))
        }
        .foregroundColor(.white)
    }
}

struct QuestionListView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionListView(
            partner: User.stub(),
            store: Store(initialState: QuestionListStore.State()) {
                QuestionListStore()
            }
        )
    }
}
