//
//  PartnerCardsView.swift
//
//
//  Created by 濵田　悠樹 on 2023/08/03.
//

import ReadabilityModifier
import SwiftUI

public struct PartnerCardsView: View {
    @State var cardImage: Image = Image(uiImage: UIImage())

    public init() {}

    public var body: some View {
        ScrollView {
            VStack(spacing: 18) {
                ForEach(0..<5) { i in
                    HStack(spacing: 12) {
                        ForEach(0..<3) { i in
                            partnerCard()
                        }
                    }
                }
            }
            .fitToReadableContentGuide()
        }
        .onAppear {
            cardImage = Image("nagano")
        }
    }

    private func partnerCard() -> some View {
        ZStack {
            card()
            partnerInfo(name: "ながのめいですす", age: 24, affiliation: "フレンドリー")
                .offset(x: 0, y: 400 * 0.42 * 0.25)
        }
    }

    private func card() -> some View {
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
        PartnerCardsView()
    }
}
