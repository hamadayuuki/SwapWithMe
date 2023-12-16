//
//  FirstView.swift
//
//
//  Created by 濵田　悠樹 on 2023/11/23.
//

import SwiftUI

public struct FirstView: View {
    @Environment(\.appViewBuilding) var appViewBuilding

    public init() {}

    public var body: some View {
        NavigationView {
            NavigationLink {
                //appViewBuilding.build(viewType: .firstView(id: 0))
            } label: {
                Text("FirstView(EmptyView())")
            }
        }
    }
}

#Preview {
    FirstView()
}
