//
//  QuestionTextEditor.swift
//
//
//  Created by 濵田　悠樹 on 2024/04/15.
//

import SwiftUI

public func QuestionTextEditor(title: String, text: Binding<String>) -> some View {
    VStack(alignment: .leading, spacing: 4) {
        HStack(spacing: 12) {
            Text(title)
                .font(.system(size: 16, weight: .semibold, design: .rounded))
                .frame(maxWidth: 80, maxHeight: 80, alignment: .topLeading)

            TextEditor(text: text)
                .frame(maxWidth: .infinity, maxHeight: 80, alignment: .topLeading)
        }

        Divider()
            .frame(height: 1)
            .background(.gray)
    }
}
