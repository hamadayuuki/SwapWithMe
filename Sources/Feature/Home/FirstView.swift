//
//  FirstView.swift
//
//
//  Created by 濵田　悠樹 on 2023/11/23.
//

import Dependencies
import Routing
import SwiftUI

public struct FirstView: View {
    //   @Environment(\.viewBuilding) var viewBuilding
    @Dependency(\.viewBuildingClient.secondView) var secondView

    public init() {}

    public var body: some View {
        NavigationView {
            NavigationLink {
                //                AnyView(viewBuilding.build(viewType: .secondView))
                secondView()
            } label: {
                Text("to Second View")
            }
        }
    }
}

#Preview {
    FirstView()
}
