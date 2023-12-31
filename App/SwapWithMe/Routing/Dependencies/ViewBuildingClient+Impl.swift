//
//  ViewBuildingClientImpl.swift
//  SwapWithMe
//
//  Created by 濵田　悠樹 on 2023/12/24.
//

import Dependencies
import Home
import QuestionList
import Routing
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
            }
        )
    }
}
