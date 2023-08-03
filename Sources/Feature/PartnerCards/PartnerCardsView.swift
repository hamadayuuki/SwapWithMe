//
//  PartnerCardsView.swift
//
//
//  Created by 濵田　悠樹 on 2023/08/03.
//

import ReadabilityModifier
import SwiftUI

public struct PartnerCardsView: View {

    public init() {}

    public var body: some View {
        ScrollView {
            VStack(spacing: 18) {
                ForEach(0..<5) { i in
                    HStack(spacing: 12) {
                        ForEach(0..<3) { i in
                            Text("Card")
                                .frame(width: 250 * 0.42, height: 400 * 0.42)
                                .background(.gray.opacity(0.5))
                                .cornerRadius(20)
                        }
                    }
                }
            }
            .fitToReadableContentGuide()
        }
    }
}

struct PartnerCardsView_Previews: PreviewProvider {
    static var previews: some View {
        PartnerCardsView()
    }
}
