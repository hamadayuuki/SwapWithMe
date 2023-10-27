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
import ViewComponents

public struct PartnerSearchView: View {
    @State private var searchText = ""
    @State private var users: [User] = []

    public init() {}

    public var body: some View {
        NavigationView {
            ZStack {
                List(users, id: \.self) { user in
                    partnerCell(partner: user)
                        .onTapGesture {
                            // tappedPartnerCell()
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

                //                NavigationLink(
                //                    destination: HomeView(myInfo: self.myInfo, partner: self.partner),
                //                    isActive: $isTransHomeView
                //                ) {
                //                    EmptyView()
                //                }
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
