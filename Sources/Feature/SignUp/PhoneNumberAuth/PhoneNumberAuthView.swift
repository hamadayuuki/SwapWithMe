//
//  PhoneNumberAuthView.swift
//  
//
//  Created by 濵田　悠樹 on 2023/07/08.
//

import FirebaseAuth
import PopupView
import SwiftUI
import ViewComponents

struct PhoneNumberAuthView: View {
    @State private var phoneNumber = ""
    @State private var isShowConfirmVerificationCodeView = false
    @State private var isErrorBanner = false

    private var isButtonEnable: Bool {
        if phoneNumber.count == 11 {
            return true
        }
        return false
    }
    private var transButtonBackground: Color {
        if isButtonEnable {
            return Color.green
        }
        return Color.gray.opacity(0.5)
    }

    var body: some View {
        VStack(spacing: 18) {
            VStack(alignment: .leading, spacing: 18) {
                Text("電話番号を使用して登録")
                    .font(.system(size: 24, weight: .bold, design: .rounded))

                Text("間違った電話番号を登録すると、メッセージが届かずユーザー登録できません。")
                    .font(.system(size: 12, weight: .regular, design: .rounded))

                TextField("000-0000-0000", text: $phoneNumber)
                    .font(.system(size: 32, weight: .bold, design: .rounded))
                    .padding(.top, 40)
                    .keyboardType(.numberPad)
                
                Divider()
                    .frame(height: 5)
                    .background(.gray)
            }

            Button(action: {
                fetchSMS()
            }, label: {
                Text("次へ")
                    .foregroundColor(.white)
                    .font(.system(size: 24, weight: .bold, design: .rounded))
                    .frame(maxWidth: .infinity, maxHeight: 50)
                    .background(transButtonBackground)
                    .cornerRadius(10)
            })
            .padding(.top, 40)
            .disabled(!isButtonEnable)

            NavigationLink(destination: ConfirmVerificationCodeView(), isActive: $isShowConfirmVerificationCodeView) {
                EmptyView()
            }
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .fitToReadableContentGuide()
        .padding(.top, 60)
        .popup(isPresented: $isErrorBanner) {
            ErrorBanner(errorTitle: "電話番号の認証に失敗しました")
                .fitToReadableContentGuide()
        } customize: {
            $0
                .type(.floater())
                .position(.bottom)
                .animation(.spring())
                .closeOnTapOutside(true)
                .backgroundColor(.black.opacity(0.3))
        }
    }

    private func fetchSMS() {
        // Firebase Auth のテストデータとして私用の電話番号を設定済み
        PhoneAuthProvider.provider()
          .verifyPhoneNumber("+81" + phoneNumber, uiDelegate: nil) { verificationID, error in
              if let error = error {
                  isErrorBanner = true
                  return
              }
              UserDefaults.standard.set(verificationID, forKey: "verificationID")
              isShowConfirmVerificationCodeView = true
          }
    }
}

struct PhoneNumberAuthView_Previews: PreviewProvider {
    static var previews: some View {
        PhoneNumberAuthView()
    }
}
