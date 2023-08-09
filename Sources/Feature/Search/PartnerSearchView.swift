//
//  PartnerSearchView.swift
//
//
//  Created by 濵田　悠樹 on 2023/08/06.
//

import Home
import ReadabilityModifier
import Request
import SwiftUI
import User

public struct PartnerSearchView: View {
    @State private var searchText = ""
    @State private var myInfo: User = .init(iconURL: nil, name: "", age: 0, sex: .man, affiliation: .juniorHigh, animal: .dog, activity: .indoor, personality: .shy, description: "")
    @State private var partner: User = .init(iconURL: nil, name: "", age: 0, sex: .man, affiliation: .juniorHigh, animal: .dog, activity: .indoor, personality: .shy, description: "")
    @State private var users: [User] = []
    @State private var isTransHomeView = false

    public init() {}

    public var body: some View {
        NavigationView {
            ZStack {
                List(users, id: \.self) { user in
                    partnerCell(partner: user)
                        .onTapGesture {
                            self.partner = user
                            self.isTransHomeView = true
                        }
                }
                .searchable(text: $searchText)
                .onSubmit(of: .search) {
                    if searchText.count <= 8 {
                        Task {
                            self.users = try await UserRequest.fetchWithName(name: searchText)
                        }
                    }
                }

                NavigationLink(
                    destination: HomeView(myInfo: self.myInfo, partner: self.partner),
                    isActive: $isTransHomeView
                ) {
                    EmptyView()
                }
            }
        }
        .onAppear {
            Task {
                // TODO: uid はログインしているユーザー情報から取得してくる
                // 現在の uid はテストユーザー
                self.myInfo = try await UserRequest.fetch(id: "8FA167F4-E3CD-449A-92F2-7FC2CB5CB0B4")
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
