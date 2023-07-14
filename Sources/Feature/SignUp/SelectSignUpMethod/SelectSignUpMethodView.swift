//
//  SelectSignUpMethodView.swift
//
//
//  Created by 濵田　悠樹 on 2023/07/06.
//

import PopupView
import ReadabilityModifier
import SwiftUI

public struct SelectSignUpMethodView: View {
    public init() {}

    public var body: some View {
        let signUpTypes: [SignUpButtonType] = [.phone, .apple, .google]

        NavigationView {
            VStack(spacing: 24) {
                ForEach(signUpTypes, id: \.id) { signUpType in
                    signUpButton(button: signUpType.model)
                }
            }
            .fitToReadableContentGuide(type: .width)
        }
    }

    private func signUpButton(button: SignUpButton) -> some View {
        NavigationLink {
            // TODO: 遷移先変更
            switch button.type {
            case .phone: PhoneNumberAuthView()
            case .apple: PhoneNumberAuthView()
            case .google: PhoneNumberAuthView()
            }
        } label: {
            ZStack {
                Text(button.title)
                    .foregroundColor(button.foregroundColor)
                    .font(.system(size: 16, weight: .bold, design: .rounded))
                Image(systemName: button.icon)
                    .font(.system(size: 24))
                    .foregroundColor(button.foregroundColor)
                    .frame(width: 300 - 40, alignment: .leading)
            }
            .frame(width: 300, height: 50)
            .background(button.backgroundColor)
            .cornerRadius(100)
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SelectSignUpMethodView()
    }
}
