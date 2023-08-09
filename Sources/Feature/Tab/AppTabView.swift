//
//  AppTabView.swift
//
//
//  Created by 濵田　悠樹 on 2023/08/06.
//

import PartnerCards
import Search
import SwiftUI

private enum Tab {
    case home
    case search
}

public struct AppTabView: View {
    @State private var selection: Tab = .home

    public init() {}

    public var body: some View {
        TabView(selection: $selection) {
            PartnerCardsView()
                .tabItem {
                    Label("ホーム", systemImage: selection == .home ? "house.fill" : "house")
                }
                .tag(Tab.home)

            PartnerSearchView()
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
