//
//  AppTabView.swift
//
//
//  Created by 濵田　悠樹 on 2023/08/06.
//

import ComposableArchitecture
import PartnerCards
import PartnerCardsStore
import Routing
import Search
import SwiftUI

private enum Tab {
    case home
    case search
}

public struct AppTabView: View {
    @Dependency(\.viewBuildingClient.partnerCardsView) var partnerCardsView

    @State private var selection: Tab = .home
    @State private var partnerCardsStore: StoreOf<PartnerCardsStore> = Store(initialState: PartnerCardsStore.State()) {
        PartnerCardsStore()
    }

    public init() {}

    public var body: some View {
        TabView(selection: $selection) {
            partnerCardsView(partnerCardsStore)
            .tabItem {
                Label("ホーム", systemImage: selection == .home ? "house.fill" : "house")
            }
            .tag(Tab.home)

            PartnerSearchView(
                store: Store(initialState: PartnerSearchStore.State()) {
                    PartnerSearchStore()
                }
            )
            .tabItem {
                Label("探す", systemImage: "magnifyingglass")
            }
            .tag(Tab.search)
        }
        .accentColor(.green)
    }
}

struct AppTabView_Previews: PreviewProvider {
    static var previews: some View {
        AppTabView()
    }
}
