//
//  SwiftUIView.swift
//
//
//  Created by 濵田　悠樹 on 2024/03/22.
//

import SwiftUI

public func QuestionTextField(title: String, placeholder: String, text: Binding<String>) -> some View {
    VStack(alignment: .leading, spacing: 4) {
        HStack(spacing: 12) {
            Text(title)
                .font(.system(size: 16, weight: .semibold, design: .rounded))
                .frame(maxWidth: 80, alignment: .leading)

            TextField(placeholder, text: text)
                .frame(maxWidth: .infinity, alignment: .leading)
        }

        Divider()
            .frame(height: 1)
            .background(.gray)
    }
}
