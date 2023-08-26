//
//  QuestionListView.swift
//
//
//  Created by 濵田　悠樹 on 2023/07/31.
//

import ReadabilityModifier
import SwiftUI

private struct Question {
    let title: String
    let description: String
}

public struct QuestionListView: View {
    private let questions: [Question] = [
        .init(title: "愛犬の名前と品種", description: "あなたの愛犬の名前と品種は何ですか？その子を選んだ理由や特徴を教えてください。"),
        .init(title: "人付き合いの楽しみ", description: "だーはまさん と テスト3さん はどちらもフレンドリーな性格です。お互いの人付き合いや交友関係について話すことで、人に対するアプローチや友情について共有することができます。"),
        .init(title: "おしゃれキャンプアイテム", description: "アウトドアに行く時、可愛いデザインや機能性で気に入っているアイテムはありますか？"),
        .init(title: "新しい場所の発見", description: "新しい場所への興味を共有することができます。A8さんはアウトドア派なので、お互いに新しい場所やスポットの情報を交換し、未知の場所を訪れる楽しみを共有することができます。"),
        .init(title: "ミュニケーションのスタイルについて", description: "コミュニケーションに対するアプローチや考え方について話すことができます。例えば、「シャイな方とお話しするとき、どのようなコミュニケーションが心地よいと思いますか？」と質問することで、お互いのコミュニケーションのスタイルについて共有することができます。"),
        .init(title: "友情の大切さ", description: "どちらもフレンドリーな性格であり、友情について話すことができます。お互いの友情の価値や大切さについて語り、友人関係の築き方や維持方法についてアドバイスを交換することで、より豊かな友情を育むヒントを得ることができます。"),

        .init(title: "ペットの話題", description: "テスト3さん はペットを飼っているため、お互いのペットについて話すことができます。例えば、「ペットを飼っているんですね。どんなペットを飼っているんですか？一緒に過ごす時間は楽しいですか？」と尋ねることで、ペットに関する共通の話題から会話が始まります。"),
        .init(title: "おすすめの犬とのデートスポット", description: "犬と一緒に楽しめる、おしゃれや可愛いスポットのおすすめはありますか？"),
        .init(title: "愛犬との思い出の写真", description: "愛犬とのアウトドアの思い出で、特にお気に入りの写真や場面はありますか？"),
        .init(title: "アウトドアファッション", description: "アウトドア活動時に気を付けているファッションやアクセサリーについて、何か特別なポイントやおすすめのブランドはありますか？"),
    ]
    @State var cardImage: Image

    public init(cardImage: Image) {
        self.cardImage = cardImage
    }

    public var body: some View {
        ScrollView {
            VStack(spacing: 32) {
                ZStack {
                    card()
                    partnerInfo(name: "テスト3", age: 24, affiliation: "フレンドリー")
                        .offset(x: 0, y: 400 * 0.7 * 0.25)
                }

                ForEach(0..<questions.count) { i in
                    questionText(questionNum: i, question: questions[i])
                }
            }
            .fitToReadableContentGuide()
        }
    }

    private func card() -> some View {
        ZStack(alignment: .top) {
            Image("partner")
                .resizable()
                .scaledToFill()

            //            cardImage
            //                .resizable()
            //                .scaledToFill()

            LinearGradient(
                gradient: Gradient(colors: [.clear, .black.opacity(0.7)]),
                startPoint: .top,
                endPoint: .bottom
            )

            Text("2023/04/01")
                .font(.system(size: 12, weight: .bold, design: .rounded))
                .foregroundColor(.white)
                .frame(width: 250 * 0.7 * 0.5, height: 20)
                .background(Color.green.cornerRadius(5))
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

    private func questionText(questionNum: Int, question: Question) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Q\(questionNum + 1) : \(question.title)？")
                .font(.system(size: 18, weight: .semibold, design: .rounded))

            Text("\(question.description)")
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
