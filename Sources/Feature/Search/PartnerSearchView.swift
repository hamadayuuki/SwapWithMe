//
//  PartnerSearchView.swift
//
//
//  Created by 濵田　悠樹 on 2023/08/06.
//

import ReadabilityModifier
import Request
import SwiftUI
import User

private struct Partner: Hashable {
    var uid: Int
    var iconURL: String
    var name: String
    var description: String
}

public struct PartnerSearchView: View {
    @State private var searchText = ""
    private var partners: [Partner] = [
        .init(uid: 0, iconURL: "kiyohara", name: "きよはらしょうう", description: "こんにちは。きよはらしょうです。モデルをやっています。"),
        .init(uid: 1, iconURL: "nagano", name: "ながのめいです", description: "こんばんは！。ながのめいです。女優をやっています。"),
        .init(uid: 2, iconURL: "narita", name: "なりたりょう", description: "どうも！モデルをやっています。短髪です。"),
        .init(uid: 3, iconURL: "hotta", name: "ほったまゆですす", description: "ども！笑顔が素敵と言われます。よろしくお願いしますっ！"),
        .init(uid: 4, iconURL: "nagano2", name: "ながのめいで2", description: "こんにちは。ながのめいです。女優をやっています。２"),
    ]
    @State private var users: [User] = []

    public init() {}

    public var body: some View {
        NavigationView {
            List(users, id: \.self) { user in
                partnerCell(partner: user)
            }
            .searchable(text: $searchText)
            .onSubmit(of: .search) {
                if searchText.count <= 8 {
                    Task {
                        self.users = try await UserRequest.fetchWithName(name: searchText)
                    }
                }
            }
        }
    }

    private func partnerCell(partner: User) -> some View {
        HStack(spacing: 18) {
            AsyncImage(url: partner.iconURL!) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 42, height: 42)
            .cornerRadius(42 * 0.5)

            VStack(alignment: .leading, spacing: 6) {
                Text(partner.name)
                    .font(.system(size: 18, weight: .bold, design: .rounded))
                Text(partner.description)
                    .font(.system(size: 12, weight: .regular, design: .rounded))
                    .foregroundColor(.gray)
            }
        }
        .padding(.vertical, 12)
    }
}

struct PartnerSearchView_Previews: PreviewProvider {
    static var previews: some View {
        PartnerSearchView()
    }
}
