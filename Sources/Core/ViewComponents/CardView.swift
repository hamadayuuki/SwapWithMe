//
//  SwiftUIView.swift
//
//
//  Created by 濵田　悠樹 on 2024/02/08.
//

import SwiftUI
import User

public struct CardView: View {
    let cardImage: Image
    let partner: PartnerInfo
    let cardSize: CGSize

    public init(cardImage: Image, partner: PartnerInfo, cardSize: CGSize = .init(width: 250, height: 400)) {
        self.cardImage = cardImage
        self.partner = partner
        self.cardSize = cardSize
    }

    public var body: some View {
        ZStack {
            card(cardImage: cardImage, cardSize: cardSize)
            partnerInfo(name: partner.name, age: partner.age, affiliation: partner.personality)
                .offset(x: 0, y: cardSize.height * 0.42 * 0.25)
        }
    }

    // MARK: - Card

    private func card(cardImage: Image, cardSize: CGSize) -> some View {
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
        .frame(width: cardSize.width * 0.42, height: cardSize.height * 0.42)
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

#Preview {
    CardView(cardImage: Image(""), partner: .init(name: "hoge", age: 20, personality: "huga"))
}
