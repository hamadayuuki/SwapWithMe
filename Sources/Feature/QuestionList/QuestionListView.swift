//
//  QuestionListView.swift
//
//
//  Created by 濵田　悠樹 on 2023/07/31.
//

import ReadabilityModifier
import SwiftUI

public struct QuestionListView: View {
    @State var cardImage: Image

    public init(cardImage: Image) {
        self.cardImage = cardImage
    }

    public var body: some View {
        ScrollView {
            VStack(spacing: 32) {
                ZStack {
                    card()
                    partnerInfo(name: "ながのめいですす", age: 24, affiliation: "フレンドリー")
                        .offset(x: 0, y: 400 * 0.7 * 0.25)
                }
                questionText(questionNum: 1)
                questionText(questionNum: 2)
                questionText(questionNum: 3)
                questionText(questionNum: 4)
                questionText(questionNum: 5)
                questionText(questionNum: 6)
                questionText(questionNum: 7)
                questionText(questionNum: 8)
                questionText(questionNum: 9)
            }
            .fitToReadableContentGuide()
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
        .frame(width: 250 * 0.7, height: 400 * 0.7)
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

    private func questionText(questionNum: Int) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Q\(questionNum) : 好きなサッカーチームは？")
                .font(.system(size: 18, weight: .semibold, design: .rounded))

            Text("2人ともサッカーが好きという共通点があります。このことから好きなサッカーチームについて話をするのが良いと思います。")
                .font(.system(size: 16, weight: .regular, design: .rounded))
                .foregroundColor(.gray)
        }
    }
}

struct QuestionListView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionListView(cardImage: Image("nagano"))
    }
}
