//
//  QuestionListView.swift
//
//
//  Created by 濵田　悠樹 on 2023/07/31.
//

import ReadabilityModifier
import SwiftUI

public struct QuestionListView: View {

    public init() {}

    public var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("趣味についての質問")
                .font(.system(size: 24, weight: .bold, design: .rounded))
                .foregroundColor(.green)

            Text("好きなサッカーチームは？")
                .font(.system(size: 18, weight: .semibold, design: .rounded))

            Text("2人ともサッカーが好きという共通点があります。このことから好きなサッカーチームについて話をするのが良いと思います。")
                .font(.system(size: 16, weight: .regular, design: .rounded))
                .foregroundColor(.gray)
        }
        .fitToReadableContentGuide()
    }
}

struct QuestionListView_Previews: PreviewProvider {
    static var previews: some View {
        QuestionListView()
    }
}
