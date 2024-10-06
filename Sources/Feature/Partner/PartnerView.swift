//
//  PartnerView.swift
//
//
//  Created by 濵田　悠樹 on 2023/07/31.
//

import ComposableArchitecture
import PartnerStore
import ReadabilityModifier
import SwiftUI
import User
import ViewComponents

private struct Yahhou: Identifiable, Equatable {
    let id: UUID = .init()
    let message: String
    let time: String  // 本来はDate
    let user: String  // "myself" or "partner"
}

public struct PartnerView: View {
    private let cardSize: CGSize = .init(width: 250 * 1.7, height: 400 * 1.7)
    private let yahhous: [Yahhou] = [
        .init(message: "やっほう01", time: "12:00", user: "myself"),
        .init(message: "やっほう02", time: "13:00", user: "partner"),
        .init(message: "やっほう03", time: "14:00", user: "myself"),
        .init(message: "やっほう04", time: "15:00", user: "partner"),
        .init(message: "やっほう05", time: "16:00", user: "myself"),
        .init(message: "やっほう06", time: "17:00", user: "partner"),
        .init(message: "やっほう07", time: "18:00", user: "myself"),
    ]

    let partner: User
    let store: StoreOf<PartnerStore>
    public init(partner: User, store: StoreOf<PartnerStore>) {
        self.partner = partner
        self.store = store
    }

    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 32) {
                    card(partner: viewStore.partner)

                    // やっほう履歴
                    ForEach(yahhous) { yahhou in
                        HStack(alignment: .top, spacing: 15) {
                            VStack(spacing: 0) {
                                Circle()
                                    .fill()
                                    .frame(width: 10, height: 10)
                                    .foregroundStyle(yahhou.user == "partner" ? .green : .blue)
                                    .padding(4)
                                    .background(.white.shadow(.drop(color: .black.opacity(0.1), radius: 3)), in: .circle)
                                Rectangle()
                                    .frame(width: 1)
                                    .foregroundStyle(yahhou == yahhous.last ? .clear : .gray)
                                    .padding(.bottom, -20)  // 下に線を伸ばす
                            }
                            .offset(y: -4)

                            VStack(alignment: .leading, spacing: 6) {
                                Text(yahhou.message)
                                    .font(.system(size: 16, weight: .bold, design: .rounded))
                                Label(yahhou.time, systemImage: "clock")
                                    .font(.system(size: 14, weight: .regular, design: .rounded))
                                    .foregroundStyle(.gray)
                            }
                            .padding(15)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(yahhou.user == "partner" ? .green.opacity(0.3) : .blue.opacity(0.3), in: .rect(topLeadingRadius: 15, bottomLeadingRadius: 15))
                            .offset(y: -8)
                        }
                    }

                    // TODO: - ユーザー情報追加
                }
            }
            .onAppear {
                viewStore.send(.onAppear(partner))
            }
            .fitToReadableContentGuide()
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

struct PartnerView_Previews: PreviewProvider {
    static var previews: some View {
        PartnerView(
            partner: User.stub(),
            store: Store(initialState: PartnerStore.State()) {
                PartnerStore()
            }
        )
    }
}
