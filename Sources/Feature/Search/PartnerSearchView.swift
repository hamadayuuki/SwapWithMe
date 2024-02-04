//
//  PartnerSearchView.swift
//
//
//  Created by 濵田　悠樹 on 2023/08/06.
//

import ComposableArchitecture
import Dependencies
import ReadabilityModifier
import Request
import Routing
import SearchStore
import SwiftUI
import User
import ViewComponents

public struct PartnerSearchView: View {
    @Dependency(\.viewBuildingClient.homeView) var homeView

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
                        destination: homeView(viewStore.myInfo, viewStore.partner),
                        isActive: viewStore.binding(
                            get: { $0.isTransHomeView },
                            send: .bindingIsTransHomeView(viewStore.isTransHomeView)
                        )
                    ) {
                        EmptyView()
                    }
                }
            }
            .onAppear {
                viewStore.send(.onAppear)
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
