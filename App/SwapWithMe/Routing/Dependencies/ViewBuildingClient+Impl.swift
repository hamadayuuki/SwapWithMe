//
//  ViewBuildingClientImpl.swift
//  SwapWithMe
//
//  Created by 濵田　悠樹 on 2023/12/24.
//

import ComposableArchitecture
import Dependencies
import Home
import MyProfile
import Partner
import PartnerCards
import Routing
import Search
import SwiftUI
import Tab
import User

extension ViewBuildingClient: DependencyKey {
    public static var liveValue: ViewBuildingClient {
        return .init(
            partnerView: { partner, store in
                return AnyView(PartnerView(partner: partner, store: store))
            },
            homeView: { (myInfo, partner) in
                return AnyView(HomeView(myInfo: myInfo, partner: partner))
            },
            partnerCardsView: { store in
                return AnyView(PartnerCardsView(store: store))
            },
            partnerSearchView: { store in
                return AnyView(PartnerSearchView(store: store))
            },
            appTabView: {
                return AnyView(AppTabView())
            },
            myProfileView: { store in
                return AnyView(MyProfileView(store: store))
            }
        )
    }
}
