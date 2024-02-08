//
//  MyProfileView.swift
//
//
//  Created by 濵田　悠樹 on 2024/02/08.
//

import ReadabilityModifier
import SwiftUI
import User
import ViewComponents

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
            case .twitter: return Image("x")
            case .instagram: return Image("instagram")
            case .line: return Image("line")
            case .other(_): return Image("")
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
        ScrollView {
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
                HStack(spacing: 16) {
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
                        .font(.system(size: 16, weight: .bold, design: .rounded))
                        .frame(maxWidth: .infinity, alignment: .leading)

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 12) {
                            CardView(cardImage: Image("nagano"), partner: PartnerInfo(name: "hotta mayu", age: 25, personality: "cute"))
                            CardView(cardImage: Image("nagano2"), partner: PartnerInfo(name: "hotta mayu", age: 25, personality: "cute"))
                            CardView(cardImage: Image("nagano3"), partner: PartnerInfo(name: "hotta mayu", age: 25, personality: "cute"))
                            CardView(cardImage: Image("nagano4"), partner: PartnerInfo(name: "hotta mayu", age: 25, personality: "cute"))
                            CardView(cardImage: Image("nagano5"), partner: PartnerInfo(name: "hotta mayu", age: 25, personality: "cute"))
                            CardView(cardImage: Image("hotta"), partner: PartnerInfo(name: "hotta mayu", age: 25, personality: "cute"))
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.top, 48)
            }
        }
        .fitToReadableContentGuide()
    }
}

#Preview {
    MyProfileView()
}
