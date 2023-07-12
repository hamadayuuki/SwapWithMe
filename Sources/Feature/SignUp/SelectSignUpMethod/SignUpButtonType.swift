//
//  SignUpButtonType.swift
//  
//
//  Created by 濵田　悠樹 on 2023/07/08.
//

import Foundation
import SwiftUI

enum SignUpButtonType {
    case phone, apple, google

    var id: UUID {
        UUID()
    }

    var model: SignUpButton {
        switch self {
        case .phone: return .phone
        case .apple: return .apple
        case .google: return .google
        }
    }
}

/// EnumとStruct を組み合わせて実装する
/// これによって 型安全なSturctを呼び出し可能
struct SignUpButton {
    let type: SignUpButtonType
    let title: String
    let icon: String
    let foregroundColor: Color
    let backgroundColor: Color

    init(type: SignUpButtonType, title: String, icon: String, foregroundColor: Color, backgroundColor: Color) {
        self.type = type
        self.title = title
        self.icon = icon
        self.foregroundColor = foregroundColor
        self.backgroundColor = backgroundColor
    }
}

extension SignUpButton {
    static let phone = SignUpButton(
        type: .phone,
        title: "電話番号で続ける",
        icon: "phone.bubble.left.fill",
        foregroundColor: Color.white,
        backgroundColor: Color.green
    )

    static let apple = SignUpButton(
        type: .apple,
        title: "Appleで続ける",
        icon: "apple.logo",
        foregroundColor: Color.white,
        backgroundColor: Color.black
    )

    static let google = SignUpButton(
        type: .google,
        title: "Googleで続ける",
        icon: "globe.central.south.asia",
        foregroundColor: Color.black,
        backgroundColor: Color.gray.opacity(0.5)
    )
}
