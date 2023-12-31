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

    public init() {}

    public var body: some View {
        NavigationView {
            VStack(spacing: 24) {
                Text("Second View")
                    .foregroundStyle(.white)
                    .font(.system(size: 48, weight: .bold, design: .rounded))

                NavigationLink {
                    //                AnyView(viewBuilding.build(viewType: .secondView))
                    firstView(0)
                } label: {
                    Text("to First View")
                        .foregroundStyle(.red)
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.blue.opacity(0.6))
        }
    }
}

#Preview {
    SecondView()
}
