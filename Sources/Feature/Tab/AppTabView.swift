//
//  AppTabView.swift
//
//
//  Created by 濵田　悠樹 on 2023/08/06.
//

import Home
import PartnerCards
import SwiftUI

public struct AppTabView: View {

    public init() {}

    public var body: some View {
        NavigationView {
            TabView {
                PartnerCardsView()
                    .tabItem {
                        Label("Home", systemImage: "house")
                    }

                HomeView()
                    .tabItem {
                        Label("Search", systemImage: "magnifyingglass")
                    }
            }
        }
    }
}

struct AppTabView_Previews: PreviewProvider {
    static var previews: some View {
        AppTabView()
    }
}
