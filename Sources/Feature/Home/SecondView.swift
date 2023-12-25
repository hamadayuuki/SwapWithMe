//
//  SecondView.swift
//
//
//  Created by 濵田　悠樹 on 2023/12/25.
//

import Dependencies
import SwiftUI

public struct SecondView: View {
    @Dependency(\.viewBuildingClient.firstView) var firstView
    @State private var showSheet = false

    public init() {}

    public var body: some View {
        VStack(spacing: 24) {
            NavigationLink {
                firstView(0)
            } label: {
                Text("to First View")
            }

            Button(action: {
                showSheet.toggle()
            }) {
                Text("show Sheet")
            }
        }
        .sheet(isPresented: $showSheet) {
            firstView(0)
        }
    }
}

#Preview {
    SecondView()
}
