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

import QuestionList
import ReadabilityModifier
import SwiftUI

private struct PartnerInfo {
    let name: String
    let age: Int
    let personality: String
}

public struct PartnerCardsView: View {
    private var cardImages: [Image] = []
    private let partners = ["nagano", "hotta", "kiyohara", "narita"]
    private var partnerInfos: [PartnerInfo] = [
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

    @State private var isTransQuestionListView = false
    @State private var tappedImage = Image("")

    public init() {
        //        for partnerIndex in 0..<4 {
        //            for imageIndex in 0..<5 {
        //                if imageIndex == 0 {
        //                    cardImages.append(Image("\(partners[partnerIndex])"))
        //                } else {
        //                    cardImages.append(Image("\(partners[partnerIndex])" + "\(imageIndex + 1)"))
        //                }
        //            }
        //        }
        for i in 1..<16 {
            cardImages.append(Image("mock-\(i)"))
        }
    }

    public var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 18) {
                    Text("Swapしたユーザー")
                        .font(.system(size: 24, weight: .bold, design: .rounded))

                    Text("これまでカードを交換したユーザーが表示されています。カードをタップすると質問が表示されます。")
                        .font(.system(size: 12, weight: .regular, design: .rounded))
                        .padding(.bottom, 24)

                    ForEach(0..<5) { i in
                        HStack(spacing: 12) {
                            ForEach(0..<3) { j in
                                partnerCard(index: i * 3 + j)
                                    .onTapGesture {
                                        tappedImage = cardImages[i * 3 + j]
                                        isTransQuestionListView = true
                                    }
                            }
                        }
                    }

                    NavigationLink(
                        destination: QuestionListView(cardImage: tappedImage),
                        isActive: $isTransQuestionListView
                    ) {
                        EmptyView()
                    }
                }
                .fitToReadableContentGuide()
                .padding(.top, 36)
            }
        }
    }

    private func partnerCard(index: Int) -> some View {
        ZStack {
            card(cardImage: cardImages[index])
            partnerInfo(name: partnerInfos[index].name, age: partnerInfos[index].age, affiliation: partnerInfos[index].personality)
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
        PartnerCardsView()
    }
}
