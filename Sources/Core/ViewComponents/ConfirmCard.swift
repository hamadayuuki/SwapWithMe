//
//  ConfirmCard.swift
//
//
//  Created by 濵田　悠樹 on 2024/05/11.
//

import SwiftUI

public struct ConfirmCard: View {
    @Environment(\.dismiss) var dismiss
    let title: String
    let description: String
    var isNext: Binding<Bool>
    var onClose: () -> Void

    public init(title: String, description: String, isNext: Binding<Bool>, onClose: @escaping () -> Void) {
        self.title = title
        self.description = description
        self.isNext = isNext
        self.onClose = onClose
    }

    public var body: some View {
        VStack(spacing: 12) {
            Text("\(title)")
                .font(.system(size: 20, weight: .bold, design: .rounded))

            Text("\(description)")
                .font(.system(size: 18, weight: .regular, design: .rounded))

            VStack(spacing: 0) {
                Button(action: {
                    print("canceled")
                }) {
                    Text("次へ")
                        .font(.system(size: 18, weight: .regular, design: .rounded))
                        .foregroundStyle(.white)
                        .frame(width: 200, height: 50)
                        .background(.green)
                }

                Button(action: {
                    print("move")
                    onClose()
                }) {
                    Text("閉じる")
                        .font(.system(size: 18, weight: .regular, design: .rounded))
                        .foregroundStyle(.gray)
                        .frame(width: 200, height: 50)
                }
            }
            .padding(.top, 48)
        }
        .padding(40)
        .background(.white)
        .cornerRadius(20)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.green, lineWidth: 1)
        )
    }
}

#Preview {
    ConfirmCard(title: "title", description: "description", isNext: .constant(false), onClose: {})
}
