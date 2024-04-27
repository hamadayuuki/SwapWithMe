//
//  SwiftUIView.swift
//
//
//  Created by 濵田　悠樹 on 2024/02/08.
//

import SwiftUI
import User

public struct CardView: View {
    @State private var cardImage: Image = Image("")
    let user: User
    let cardSize: CGSize

    public init(user: User, cardSize: CGSize = .init(width: 250, height: 400)) {
        self.user = user
        self.cardSize = cardSize
    }

    public var body: some View {
        ZStack {
            card(cardImage: cardImage, cardSize: cardSize)
            partnerInfo(name: user.name, age: user.age, affiliation: user.personality.rawValue)
                .offset(x: 0, y: cardSize.height * 0.42 * 0.25)
        }
        .onAppear {
            Task {
                guard let iconURL = user.iconURL else { return }
                let uiImage = await nukeUIImage(url: iconURL)
                self.cardImage = Image(uiImage: uiImage)
            }
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
    CardView(user: User.stub())
}
