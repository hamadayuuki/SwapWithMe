//
//  AppTabView.swift
//
//
//  Created by 濵田　悠樹 on 2023/08/06.
//

import ComposableArchitecture
import Dependencies
import PartnerCardsStore
import Routing
import SearchStore
import SwiftUI

private enum Tab {
    case home
    case search
}

public struct AppTabView: View {
    @Dependency(\.viewBuildingClient.partnerCardsView) var partnerCardsView
    @Dependency(\.viewBuildingClient.partnerSearchView) var partnerSearchView

    @State private var selection: Tab = .home
    private var partnerCardsStore = Store(initialState: PartnerCardsStore.State()) {
        PartnerCardsStore()
    }
    private var partnerSearchStore = Store(initialState: PartnerSearchStore.State()) {
        PartnerSearchStore()
    }

    public init() {}

    public var body: some View {
        TabView(selection: $selection) {
            partnerCardsView(partnerCardsStore)
                .tabItem {
                    Label("ホーム", systemImage: selection == .home ? "house.fill" : "house")
                }
                .tag(Tab.home)

            partnerSearchView(partnerSearchStore)
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
