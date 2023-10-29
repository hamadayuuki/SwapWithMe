//
//  PartnerSearchView.swift
//
//
//  Created by 濵田　悠樹 on 2023/08/06.
//

import ComposableArchitecture
import Home
import ReadabilityModifier
import Request
import SwiftUI
import User
import ViewComponents

public struct PartnerSearchView: View {
    let store: StoreOf<PartnerSearchStore>

    public init(store: StoreOf<PartnerSearchStore>) {
        self.store = store
    }

    public var body: some View {
        WithViewStore(self.store, observe: { $0 }) { viewStore in
            NavigationView {
                ZStack {
                    List(viewStore.users, id: \.self) { user in
                        partnerCell(partner: user)
                            .onTapGesture {
                                viewStore.send(.tappedPartnerCell(user))
                            }
                    }
                    .searchable(text: viewStore.$searchText)
                    .onSubmit(of: .search) {
                        if viewStore.searchText.count <= 8 {
                            viewStore.send(.search(viewStore.searchText))
                        }
                    }

                    NavigationLink(
                        destination: HomeView(myInfo: viewStore.myInfo, partner: viewStore.partner),
                        isActive: viewStore.binding(
                            get: { $0.isTransHomeView },
                            send: .bindingIsTransHomeView(viewStore.isTransHomeView)
                        )
                    ) {
                        EmptyView()
                    }
                }
            }
            // 画面遷移 今後実装
            // HomeView にTCAを導入してから実装
//            .navigationDestination(
//                store: store.scope(
//                    state: \.$destination,
//                    action: { .destination($0) }
//                ),
//                state: /PartnerSearchStore.Destination.State.homeView,
//                action: PartnerSearchStore.Destination.Action.homeView,
//                destination: HomeView.init(store:)
//            )
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
        PartnerSearchView(
            store: Store(initialState: PartnerSearchStore.State()) {
                PartnerSearchStore()
            })
    }
}
