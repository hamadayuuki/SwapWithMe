//
//  ViewBuildingClientImpl.swift
//  SwapWithMe
//
//  Created by 濵田　悠樹 on 2023/12/24.
//

import Dependencies
import Home
import PartnerCards
import QuestionList
import Routing
import SignUp
import SwiftUI

extension ViewBuildingClient: DependencyKey {
    public static var liveValue: ViewBuildingClient {
        return .init(
            firstView: { id in
                return AnyView(FirstView())
            },
            secondView: {
                return AnyView(SecondView())
            },
            questionListView: { cardImage in
                return AnyView(QuestionListView(cardImage: cardImage))
            },
            homeView: { myInfo, partner in
                return AnyView(HomeView(myInfo: myInfo, partner: partner))
            },
            partnerCardsView: { store in
                return AnyView(PartnerCardsView(store: store))
            }
        )
    }
}
