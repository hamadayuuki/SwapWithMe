//
//  MyProfileView.swift
//
//
//  Created by 濵田　悠樹 on 2024/02/08.
//

import SwiftUI
import User

public struct MyProfileView: View {
    /// stub
    /// ユーザーが所持しているSNS一覧
    private enum SNS: Hashable {
        case twitter
        case instagram
        case line
        case other(String)

        var name: String {
            switch self {
            case .twitter: return "Twitter"
            case .instagram: return "Instagram"
            case .line: return "LINE"
            case let .other(name): return name
            }
        }

        var icon: Image {
            switch self {
            case .twitter: return Image("hotta2")
            case .instagram: return Image("hotta3")
            case .line: return Image("hotta4")
            case .other(_): return Image("hotta5")
            }
        }
    }

    /// stub
    /// フォロー, フォロワー, やっほう数
    private enum MyStatus: Hashable {
        case following
        case follower
        case yahhos

        var title: String {
            switch self {
            case .following: return "Following"
            case .follower: return "Follower"
            case .yahhos: return "やっほう数"
            }
        }

        var num: Int {
            switch self {
            case .following: return 100
            case .follower: return 300
            case .yahhos: return 500
            }
        }
    }

    // TODO: 動的にする, 今は表示用にデータを決めうちで定義
    private let mySns: [SNS] = [.twitter, .instagram, .line, .other("BeReal.")]
    private let myStatus: [MyStatus] = [.follower, .following, .yahhos]

    public init() {}

    public var body: some View {
        VStack(spacing: 24) {
            // アイコン
            Image("hotta")
                .resizable()
                .scaledToFill()
                .frame(width: 150, height: 150)
                .cornerRadius(75)
                .overlay(
                    RoundedRectangle(cornerRadius: 75).stroke(Color.black, lineWidth: 4)
                )

            // ユーザー情報
            VStack(spacing: 12) {
                Text("@hotta_mayu")
                    .font(.system(size: 24, weight: .bold, design: .rounded))
                Text("hello, my name is hotta mayu")
                    .font(.system(size: 16, weight: .regular, design: .rounded))
                    .foregroundStyle(.gray)
            }

            // SNSアイコン
            HStack(spacing: 12) {
                ForEach(mySns, id: \.self) { sns in
                    sns.icon
                        .resizable()
                        .scaledToFit()
                        .frame(width: 50, height: 50)
                        .cornerRadius(25)
                        .overlay(
                            RoundedRectangle(cornerRadius: 25).stroke(Color.black, lineWidth: 1)
                        )
                }
            }
            .frame(maxWidth: .infinity)

            // フォロー, フォロワー, やっほう数
            HStack(spacing: 24) {
                ForEach(myStatus, id: \.self) { status in
                    VStack(spacing: 4) {
                        Text("\(status.num)")
                            .font(.system(size: 20, weight: .bold, design: .rounded))
                        Text(status.title)
                            .font(.system(size: 12, weight: .regular, design: .rounded))
                    }
                    if status == .follower || status == .following {
                        Divider()
                    }
                }
            }
            .frame(maxHeight: 50)

            VStack(spacing: 12) {
                Text("最近交換したユーザー")
                    .font(.system(size: 24, weight: .bold, design: .rounded))

                HStack(spacing: 12) {
                    partnerCard(cardImage: Image(""), partner: PartnerInfo(name: "hotta mayu", age: 25, personality: "cute"))
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.top, 24)
        }
    }

    // MARK: - Card

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

#Preview {
    MyProfileView()
}
