//
//  FirstView.swift
//
//
//  Created by 濵田　悠樹 on 2023/11/23.
//

import Routing
import SwiftUI

public struct FirstView: View {
    @Environment(\.viewBuilding) var viewBuilding

    public init() {}

    public var body: some View {
        NavigationView {
            NavigationLink {
                AnyView(viewBuilding.build(viewType: .secondView))
            } label: {
                Text("to Second View")
            }
        }
    }
}

#Preview {
    FirstView()
}
